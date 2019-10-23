import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/Period.dart';
import 'package:lbp/etc/HexColor.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';

class OverviewScreen extends StatelessWidget {
  final data = _LessonOverviewData(
    color: "#16b8c9",
    room: "H922",
    subject: "AI / Data Science",
    note: "note",
    period: Period.fromJson({
      "begin": "2019-10-10T11:20:00.000Z",
      "end": "2019-10-10T14:50:00.000Z",
      "name": "afternoon"
    }),
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _OverviewData>(
      converter: (store) => _OverviewData(lessons:
          List<_LessonOverviewData>.from(store.state.days.data.days.map((d) {
        Lesson l = d.getSelectedLesson();
        return _LessonOverviewData(
          color: l?.color ?? '#000000',
          period: d.period,
          note: d.note.isEmpty ? "Note" : d.note,
          room: l?.room ?? 'Raum',
          subject: l?.subject ?? 'Gegenstand',
        );
      }))),
      builder: (context, model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: model.lessons.map((l) => _LessonOverview(l)).toList(),
        );
      },
    );
    /*return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _LessonOverview(data),
        _LessonOverview(data),
        _LessonOverview(data),
      ],
    );*/
  }
}

class _OverviewData {
  List<_LessonOverviewData> lessons;

  _OverviewData({this.lessons});
}

class _LessonOverviewData {
  Period period;
  String color;
  String subject;
  String room;
  String note;

  _LessonOverviewData(
      {this.period, this.color, this.subject, this.room, this.note});
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
