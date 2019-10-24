class LessonStrings {
  final Map<String, LessonStringsEntry> subjects;

  LessonStrings({this.subjects = const {}});

  factory LessonStrings.fromJson(Map<String, dynamic> json) => LessonStrings(
        subjects: json.map((k, v) => MapEntry<String, LessonStringsEntry>(k,
            LessonStringsEntry.fromJson(List<String>.from(v.map((x) => x))))),
      );

  String getLessonLong(String id) {
    if(id == null) return null;
    return subjects[id].long;
  }

  String getLessonShort(String id) {
    if(id == null) return null;
    return subjects[id].short;
  }
}

class LessonStringsEntry {
  String long;
  String short;

  LessonStringsEntry({this.long, this.short});

  factory LessonStringsEntry.fromJson(List<String> json) =>
      LessonStringsEntry(long: json[0], short: json[1]);

  List<String> toJson() => [
        long,
        short,
      ];
}
