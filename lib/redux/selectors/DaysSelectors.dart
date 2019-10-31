import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';

import '../AppState.dart';

List<Day> daysListSelector(AppState state) {
  return state.days.data?.days ?? List();
}

Day dayOfWeekDaySelector(AppState state, int weekDay) {
  for(Day d in daysListSelector(state)) {
    if(d.getWeekDay() == weekDay) {
      return d;
    }
  }
  return null;
}

List<Class> classesOfDaySelector(AppState state, int weekDay) {
  Day d = dayOfWeekDaySelector(state, weekDay);
  return d == null ? List() : d.classes;
}

Class classOfDayAndClassSelector(AppState state, int weekDay, int $class) {
  return classesOfDaySelector(state, weekDay)[$class];
}

List<Lesson> lessonsOfDayAndClassSelector(AppState state, int weekDay, int $class) {
  return classOfDayAndClassSelector(state, weekDay, $class).lessons;
}

TimeFrame periodOfDayAndClassSelector(AppState state, int weekDay, int $class) {
  return classesOfDaySelector(state, weekDay).first.period;
}