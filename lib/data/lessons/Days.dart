import 'package:lbp/api/ApiResponse.dart';

import 'Day.dart';

class Days extends ApiResponses {
  List<Day> days;

  Days({this.days});

  Days.fromJson(List<dynamic> json) {
    days = List<Day>.from(json.map((d) => Day.fromJson(d[0])));
  }

  @override
  String toString() {
    return 'Days{days: $days}';
  }
}