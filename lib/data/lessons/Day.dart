import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/Period.dart';

class Day extends ApiResponses {
  List<Lesson> lessons;
  String note;
  Period period;
  bool visible;

  Day({this.lessons, this.note, this.period, this.visible});

  Day.fromJson(Map<String, dynamic> json) {
    lessons = List<Lesson>.from(
        json['lessons'].map((_json) => Lesson.fromJson(_json)));
    note = json['note'];
    period = Period.fromJson(json['period']);
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lessons'] = lessons.map((l) => l.toJson()).toList();
    data['note'] = note;
    data['period'] = period.toJson();
    data['visible'] = visible;
    return data;
  }

  @override
  String toString() {
    return 'Day{lessons: $lessons, note: $note, period: $period, visible: $visible}';
  }
}
