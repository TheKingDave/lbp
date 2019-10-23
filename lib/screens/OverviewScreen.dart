import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/Period.dart';
import 'package:lbp/etc/HexColor.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/ui/Loader.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _OverviewData>(
      converter: (store) => _OverviewData(
          loading: store.state.days.loading,
          lessons: store.state.days.data == null
              ? List<_LessonOverviewData>()
              : List<_LessonOverviewData>.from(
                  store.state.days.data.days.map((d) {
                  Lesson l = d.getSelectedLesson();
                  return _LessonOverviewData(
                    color: l?.color,
                    period: d.period,
                    note: d.note,
                    room: l?.room,
                    subject: l?.subject,
                  );
                }))),
      builder: (context, model) {
        return Loader(
          loading: model.loading,
          build: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: model.lessons.map((l) => _LessonOverview(l)).toList(),
            );
          },
        );
      },
    );
  }
}

class _OverviewData {
  List<_LessonOverviewData> lessons;
  bool loading;

  _OverviewData({this.lessons, this.loading});
}

class _LessonOverviewData {
  final Period period;
  final String color;
  final String subject;
  final String room;
  final String note;

  _LessonOverviewData(
      {this.period, String color, String subject, String room, String note})
      : this.color = color ?? "#000000",
        this.subject = subject ?? "Gegenstand",
        this.room = room ?? "Raum",
        this.note = note.isEmpty ? "Note" : note;
}

class _LessonOverview extends StatelessWidget {
  static const bigText = TextStyle(fontSize: 24.0);
  static const mediumText = TextStyle(fontSize: 16.0);

  final _LessonOverviewData data;

  _LessonOverview(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
        // margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(width: 10.0, color: HexColor(data.color)),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.period.toString(), style: bigText),
              Text("${data.subject} ${data.room}", style: mediumText),
              Text(data.note, style: mediumText),
            ],
          ),
        ));
  }
}
