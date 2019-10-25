class DayRouteData {
  final int day;
  final int initialLesson;

  DayRouteData(this.day, {this.initialLesson = 0});

  @override
  String toString() {
    return 'DayRouteData{day: $day, initialLesson: $initialLesson}';
  }

}