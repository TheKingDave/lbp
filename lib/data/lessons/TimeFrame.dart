class TimeFrame {
  DateTime begin;
  DateTime end;
  String name;

  TimeFrame({this.begin, this.end, this.name});

  TimeFrame.fromJson(Map<String, dynamic> json) {
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

  String pad(dynamic p) {
    return p.toString().padLeft(2, '0');
  }

  String getDate() {
    DateTime b = begin.toLocal();
    return "${b.day}.${b.month}";
  }

  int getWeekDay() {
    return begin.toLocal().weekday;
  }

  @override
  String toString() {
    DateTime b = begin.toLocal();
    DateTime e = end.toLocal();

    return "${b.hour}:${pad(b.minute)} - ${e.hour}:${pad(e.minute)}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TimeFrame &&
              runtimeType == other.runtimeType &&
              begin == other.begin &&
              end == other.end &&
              name == other.name;

  @override
  int get hashCode =>
      begin.hashCode ^
      end.hashCode ^
      name.hashCode;

}
