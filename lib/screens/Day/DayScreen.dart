import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/SetDataRequest.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/HexColor.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';

class DayScreen extends StatelessWidget {
  final int weekDay;
  final int $class;

  DayScreen({@required this.weekDay, @required this.$class});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _DayScreenData>(
      converter: (store) =>
          _DayScreenData(
              lessons: lessonsOfDayAndClassSelector(
                  store.state, weekDay, $class),
              setSubject: (subject) =>
                  store.dispatch(ApiSetDataAction(
                      subject: subject,
                      period:
                      periodOfDayAndClassSelector(
                          store.state, weekDay, $class)))),
      builder: (context, model) {
        return ListView(
          physics: ClampingScrollPhysics(),
          children: List.from(model.lessons.map((l) =>
              _LessonOverview(
                lesson: l,
                setSubject: model.setSubject,
              ))),
        );
      },
    );
  }
}

class _DayScreenData {
  final List<Lesson> lessons;
  final Function(String subject) setSubject;

  _DayScreenData({this.lessons, this.setSubject});
}

class _LessonOverview extends StatelessWidget {
  static const bigText = TextStyle(fontSize: 24.0);
  static const mediumText = TextStyle(fontSize: 16.0);

  final Lesson lesson;
  final Function(String subject) setSubject;

  _LessonOverview({this.lesson, this.setSubject});

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        color: lesson.selected ? Color(0xFFDDDDDD) : null,
        child: InkWell(
          onTap: () => setSubject(lesson.subject),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 10.0, color: HexColor(lesson.color)),
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
                        child: Text(
                          Strings.lessons.getLessonLong(lesson.subject),
                          style: mediumText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                          "${lesson.currentStudents}/${lesson.maxStudents}",
                          style: bigText),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(lesson.room, style: mediumText),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              child: Text(lesson.teacher,
                                  style: mediumText.copyWith(
                                      color: Colors.black45)))),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
