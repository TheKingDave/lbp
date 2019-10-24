import 'package:lbp/api/ApiResponse.dart';

import 'Class.dart';

class Days extends ApiResponses {
  List<Class> days;

  Days({this.days});

  Days.fromJson(List<dynamic> json) {
    days = List<Class>.from(json.map((d) => Class.fromJson(d[0])));
  }

  @override
  String toString() {
    return 'Days{days: $days}';
  }
}