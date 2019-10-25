import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/etc/helpers.dart';

import '../AppState.dart';

List<Day> daysListSelector(AppState state) {
  return state.days.data?.days ?? List();
}

List<Class> classesOfDaySelector(AppState state, int weekDay) {
  for(Day d in daysListSelector(state)) {
    if(d.getWeekDay() == weekDay) {
      return d.classes;
    }
  }

  return List();
}

List<Lesson> lessonsOfDayAndClass(AppState state, int weekDay, int $class) {
  return classesOfDaySelector(state, weekDay)[$class].lessons;
}