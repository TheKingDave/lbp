import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/api/lessons/Lesson.dart';
import 'package:lbp/api/lessons/Period.dart';
import 'package:lbp/etc/HexColor.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _LessonOverview(data),
        _LessonOverview(data),
        _LessonOverview(data),
      ],
    );
  }
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

  @override
  Widget build_(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        type: MaterialType.card,
        color: Theme.of(context).cardColor,
        elevation: 1.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data.period.toString(), style: bigText),
            Text("${data.subject} ${data.room}", style: mediumText),
            Text(data.note, style: mediumText),
          ],
        ),
      ),
    );
  }
}
