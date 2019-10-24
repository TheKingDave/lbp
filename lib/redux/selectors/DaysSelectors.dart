import 'package:lbp/data/lessons/Days.dart';

import '../AppState.dart';

List<Day> daysListSelector(AppState state) {
  return state.days.data?.days;
}