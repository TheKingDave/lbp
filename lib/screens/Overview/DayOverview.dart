import 'package:flutter/cupertino.dart';

import 'ClassOverview.dart';

class DayOverview extends StatelessWidget {
  static const titleText = TextStyle(fontSize: 28.0);

  final DayOverviewData data;

  DayOverview({this.data});

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

    for (ClassOverviewData cod in data.classes) {
      children.add(ClassOverview(cod));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class DayOverviewData {
  final String weekDay;
  final String date;
  final List<ClassOverviewData> classes;

  DayOverviewData({this.weekDay, this.date, this.classes});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayOverviewData &&
          runtimeType == other.runtimeType &&
          weekDay == other.weekDay &&
          date == other.date &&
          classes == other.classes;

  @override
  int get hashCode => weekDay.hashCode ^ date.hashCode ^ classes.hashCode;
}
