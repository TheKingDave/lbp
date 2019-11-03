import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/HexColor.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';

import '../../RouteNames.dart';
import 'NoteDialog.dart';

class ClassOverview extends StatelessWidget {
  static const bigText = TextStyle(fontSize: 24.0);
  static const mediumText = TextStyle(fontSize: 16.0);

  final ClassOverviewData data;

  ClassOverview(this.data);

  @override
  Widget build(BuildContext context) {
    ThemeData t = Theme.of(context);

    final _mediumTextDisabled = mediumText.copyWith(color: t.disabledColor);

    final _bigText =
        data.visible ? bigText : bigText.copyWith(color: t.disabledColor);
    final _mediumText = data.visible ? mediumText : _mediumTextDisabled;

    return StoreConnector<AppState, _ClassOverviewModel>(
      converter: (store) => _ClassOverviewModel(
        setNote: (period, note) => store.dispatch(ApiSetNoteAction(
          period: period,
          note: note,
        ))
      ),
      builder: (_, model) => Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.studentDay,
                    arguments: data.dayRouteData);
              },
              onLongPress: () async {
                final value = await showDialog(
                    context: context,
                    builder: (context) => NoteDialog(data.note));

                if(value != data.note) {
                  model.setNote(data.period, value);
                }
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
                        Expanded(
                            child: SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Text(data.subject, style: _mediumText))),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(data.room, style: _bigText),
                        ),
                      ],
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                          child: Text(data.note ?? Strings.getCapitalize("note"),
                              style: data.note == null
                                  ? _mediumTextDisabled
                                  : _mediumText)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(data.period.toString(), style: _mediumText),
                      )
                    ]),
                  ],
                ),
              ))),
    );
  }
}

class ClassOverviewData {
  final DayRouteData dayRouteData;
  final TimeFrame period;
  final String color;
  final String subject;
  final String room;
  final String note;
  final bool visible;

  ClassOverviewData(
      {@required this.dayRouteData,
      @required this.period,
      String color,
      String subject,
      String room,
      String note,
      this.visible})
      : this.color = color ?? "#000000",
        this.subject = subject ?? Strings.lessons.getLessonLong("subject"),
        this.room = room ?? Strings.getCapitalize("a_room"),
        this.note = note.isEmpty ? null : note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassOverviewData &&
          runtimeType == other.runtimeType &&
          dayRouteData == other.dayRouteData &&
          period == other.period &&
          color == other.color &&
          subject == other.subject &&
          room == other.room &&
          note == other.note &&
          visible == other.visible;

  @override
  int get hashCode =>
      dayRouteData.hashCode ^
      period.hashCode ^
      color.hashCode ^
      subject.hashCode ^
      room.hashCode ^
      note.hashCode ^
      visible.hashCode;
}

class _ClassOverviewModel {
  final Function(TimeFrame period, String note) setNote;

  _ClassOverviewModel({this.setNote});
}
