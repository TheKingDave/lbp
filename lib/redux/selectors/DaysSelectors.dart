import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';

import '../AppState.dart';

List<Day> daysListSelector(AppState state) {
  return state.days.data?.days;
}

List<Class> classesOfDaySelector(AppState state, int weekDay) {
  for(Day d in daysListSelector(state)) {
    if(d.getWeekDay() == weekDay) {
      return d.classes;
    }
  }

  return null;
}