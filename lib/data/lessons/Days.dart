import 'package:lbp/api/ApiResponse.dart';

import 'Class.dart';

class Days extends ApiResponses {
  List<Day> days;

  Days({this.days});

  Days.fromJson(List<dynamic> json) {
    days = List<Day>.from(json.map((d) => Day.fromJson(d)));
  }

  @override
  String toString() {
    return 'Days{days: $days}';
  }
}

class Day {
  List<Class> classes;

  Day({this.classes});

  factory Day.fromJson(List<dynamic> json) =>
      Day(classes: List<Class>.from(json.map((d) => Class.fromJson(d))));

  int getWeekDay() {
    return classes.first.period.getWeekDay();
  }

  @override
  String toString() {
    return 'Day{classes: $classes}';
  }
}
