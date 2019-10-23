class Lesson {
  String subject;
  String teacher;
  String color;
  int maxStudents;
  String username;
  int currentStudents;
  bool selected;
  String room;

  Lesson(
      {this.subject,
        this.teacher,
        this.color,
        this.maxStudents,
        this.username,
        this.currentStudents,
        this.selected,
        this.room});

  Lesson.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    teacher = json['teacher'];
    color = json['color'];
    maxStudents = json['maxStudents'];
    username = json['username'];
    currentStudents = json['currentStudents'];
    selected = json['selected'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['teacher'] = this.teacher;
    data['color'] = this.color;
    data['maxStudents'] = this.maxStudents;
    data['username'] = this.username;
    data['currentStudents'] = this.currentStudents;
    data['selected'] = this.selected;
    data['room'] = this.room;
    return data;
  }

  @override
  String toString() {
    return 'Lesson{subject: $subject, teacher: $teacher, color: $color, maxStudents: $maxStudents, username: $username, currentStudents: $currentStudents, selected: $selected, room: $room}';
  }
}