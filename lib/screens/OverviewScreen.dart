import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/HexColor.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/ui/Loader.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _OverviewData>(
      converter: (store) {
        var _days = List<_DayOverviewData>();
        if (store.state.days.data != null) {
          Days days = store.state.days.data;
          _days = List<_DayOverviewData>.from(days.days.map((Day d) {
            TimeFrame p = d.classes.first.period;
            int index = 0;
            return _DayOverviewData(
              weekDay: Strings.getWeekdayString(p.getWeekDay()),
              date: p.getDate(),
              classes: List.from(d.classes.map((Class c) {
                Lesson l = c.getSelectedLesson();
                return _ClassOverviewData(
                  dayRouteData:
                      DayRouteData(d.getWeekDay(), initialLesson: index++),
                  color: l?.color,
                  period: c.period.toString(),
                  note: c.note,
                  room: l?.room,
                  subject: Strings.lessons.getLessonLong(l?.subject),
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
              padding: const EdgeInsets.all(4.0),
              children: model.days.map((d) => _DayOverview(data: d)).toList(),
            );
          },
        );
      },
    );
  }
}

class _OverviewData {
  List<_DayOverviewData> days;
  bool loading;

  _OverviewData({this.days, this.loading});
}

class _DayOverviewData {
  final String weekDay;
  final String date;
  final List<_ClassOverviewData> classes;

  _DayOverviewData({this.weekDay, this.date, this.classes});
}

class _DayOverview extends StatelessWidget {
  static const titleText = TextStyle(fontSize: 28.0);

  final _DayOverviewData data;

  _DayOverview({this.data});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(data.weekDay, style: titleText),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(data.date),
          ),
        ],
      )
    ];

    for (_ClassOverviewData cod in data.classes) {
      children.add(_ClassOverview(cod));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class _ClassOverviewData {
  final DayRouteData dayRouteData;
  final String period;
  final String color;
  final String subject;
  final String room;
  final String note;

  _ClassOverviewData(
      {@required this.dayRouteData,
      @required this.period,
      String color,
      String subject,
      String room,
      String note})
      : this.color = color ?? "#000000",
        this.subject = subject ?? "Gegenstand",
        this.room = room ?? "Raum",
        this.note = note.isEmpty ? "Note" : note;
}

class _ClassOverview extends StatelessWidget {
  static const bigText = TextStyle(fontSize: 24.0);
  static const mediumText = TextStyle(fontSize: 16.0);

  final _ClassOverviewData data;

  _ClassOverview(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
            onTap: () {
              cPrint("press ${data.dayRouteData}");
              Navigator.of(context)
                  .pushNamed(RouteNames.day, arguments: data.dayRouteData);
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(width: 10.0, color: HexColor(data.color)),
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SingleChildScrollView(
                              child: Text(data.subject, style: mediumText)),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            child: Text(data.room, style: mediumText),
                          ),
                        ],
                      ),
                      Text(data.period, style: bigText),
                    ],
                  ),
                  Text(data.note, style: mediumText),
                ],
              ),
            )));
  }
}
