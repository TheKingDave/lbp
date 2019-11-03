import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/data/lessons/Lesson.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';

class Class extends ApiResponses {
  List<Lesson> lessons;
  String note;
  TimeFrame period;
  bool visible;

  Class({this.lessons, this.note, this.period, this.visible});

  Class.fromJson(Map<String, dynamic> json) {
    lessons = List<Lesson>.from(
        json['lessons'].map((_json) => Lesson.fromJson(_json)));
    note = json['note'];
    period = TimeFrame.fromJson(json['period']);
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

  Lesson getSelectedLesson() {
    for (final l in lessons) {
      if (l.selected) {
        return l;
      }
    }

    return null;
  }

  @override
  String toString() {
    return 'Day{lessons: $lessons, note: $note, period: $period, visible: $visible}';
  }
}
