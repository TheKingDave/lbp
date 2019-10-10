import 'package:lbp/api/strings/Strings.dart';

class Period {
  DateTime begin;
  DateTime end;
  String name;

  Period({this.begin, this.end, this.name});

  Period.fromJson(Map<String, dynamic> json) {
    begin = DateTime.parse(json['begin']);
    end = DateTime.parse(json['end']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['begin'] = this.begin.toIso8601String();
    data['end'] = this.end.toIso8601String();
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    DateTime b = begin.toLocal();
    DateTime e = end.toLocal();

    return "${Strings.getWeekdayString(b.weekday)} ${b.hour}:${b.minute} - ${b.hour}:${b.minute}";
  }
}
