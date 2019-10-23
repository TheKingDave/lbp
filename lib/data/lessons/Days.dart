import 'package:lbp/api/ApiResponse.dart';

import 'Day.dart';

class Days extends ApiResponses {
  List<Day> days;

  Days({this.days});

  Days.fromJson(Map<String, dynamic> json) {
    days = json[0].map((d) => Day.fromJson(d));
  }

  List<List<Map<String, dynamic>>> toJson() {
    final List<List<Map<String, dynamic>>> data = new List<List<Map<String, dynamic>>>();
    data[0] = days.map((d) => d.toJson());
    return data;
  }
}