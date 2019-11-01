import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/HexColor.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';
import 'package:lbp/ui/OwnCircularProgressIndicator.dart';

class DayScreen extends StatelessWidget {
  final int weekDay;
  final int $class;

  DayScreen({@required this.weekDay, @required this.$class});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _DayScreenData>(
      distinct: true,
      converter: (store) => _DayScreenData(
          loading: store.state.setData.loading || store.state.days.loading,
          visible:
              classOfDayAndClassSelector(store.state, weekDay, $class).visible,
          lessons: lessonsOfDayAndClassSelector(store.state, weekDay, $class),
          setSubject: (subject) => store.dispatch(ApiSetDataAction(
              subject: subject,
              period:
                  periodOfDayAndClassSelector(store.state, weekDay, $class)))),
      builder: (context, model) {
        final children = <Widget>[
          ListView(
            physics: ClampingScrollPhysics(),
            children: List.from(model.lessons.map((l) => _LessonOverview(
                  lesson: l,
                  visible: model.visible,
                  setSubject: model.setSubject,
                ))),
          ),
        ];

        if (model.loading) {
          children.add(Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: OwnCircularProgressIndicator(),
            ),
          ));
        }

        return Stack(
          children: children,
        );
      },
    );
  }
}

class _DayScreenData {
  final bool loading;
  final bool visible;
  final List<Lesson> lessons;
  final Function(String subject) setSubject;

  _DayScreenData(
      {@required this.loading,
      @required this.visible,
      this.lessons,
      this.setSubject});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _DayScreenData &&
          runtimeType == other.runtimeType &&
          lessons == other.lessons &&
          setSubject == other.setSubject &&
          visible == other.visible &&
          loading == other.loading;

  @override
  int get hashCode =>
      lessons.hashCode ^
      setSubject.hashCode ^
      visible.hashCode ^
      loading.hashCode;
}

class _LessonOverview extends StatelessWidget {
  static const bigText = TextStyle(fontSize: 24.0);
  static const mediumText = TextStyle(fontSize: 16.0);

  final Lesson lesson;
  final bool visible;
  final Function(String subject) setSubject;

  _LessonOverview({this.lesson, this.visible, this.setSubject});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    final _bigText =
        visible ? bigText : bigText.copyWith(color: t.disabledColor);
    final _mediumText =
        visible ? mediumText : mediumText.copyWith(color: t.disabledColor);

    return Card(
        clipBehavior: Clip.hardEdge,
        color: lesson.selected ? Color(0xFFDDDDDD) : null,
        child: InkWell(
          onTap: visible ? () => setSubject(lesson.subject) : null,
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
                          style: _mediumText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                          "${lesson.currentStudents}/${lesson.maxStudents}",
                          style: _bigText),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(lesson.room, style: _mediumText),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              child: Text(lesson.teacher,
                                  style: _mediumText.copyWith(
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
