import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/ui/Loader.dart';

import 'ClassOverview.dart';
import 'DayOverview.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _OverviewData>(
      distinct: true,
      converter: (store) {
        var _days = List<DayOverviewData>();
        if (store.state.days.data != null) {
          Days days = store.state.days.data;
          _days = List<DayOverviewData>.from(days.days.map((Day d) {
            TimeFrame p = d.classes.first.period;
            int index = 0;
            return DayOverviewData(
              weekDay: Strings.getWeekdayString(p.getWeekDay()),
              date: p.getDate(),
              classes: List.from(d.classes.map((Class c) {
                Lesson l = c.getSelectedLesson();
                return ClassOverviewData(
                  dayRouteData:
                      DayRouteData(d.getWeekDay(), initialLesson: index++),
                  color: l?.color,
                  period: c.period,
                  note: c.note,
                  room: l?.room,
                  subject: Strings.lessons.getLessonLong(l?.subject),
                  visible: c.visible,
                );
              })),
            );
          }));
        }

        return _OverviewData(loading: store.state.days.loading, days: _days);
      },
      builder: (context, model) {
        return Loader(
          loading: model.loading,
          build: (context) {
            // For refresh indicator: https://github.com/brianegan/flutter_redux/issues/6
            return ListView(
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.all(4.0),
              children: List.from(model.days.map((d) => DayOverview(data: d))),
            );
          },
        );
      },
    );
  }
}

class _OverviewData {
  List<DayOverviewData> days;
  bool loading;

  _OverviewData({this.days, this.loading});
}
