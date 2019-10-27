class DayTimeStrings {
  final Map<String, String> entries;
  static const Map<int, String> times = {4: "morning", 12: "afternoon", 18: "evening"};

  DayTimeStrings({this.entries});

  factory DayTimeStrings.fromJson(Map<String, String> json) =>
      DayTimeStrings(entries: json);

  getGood() {
    return entries['good'];
  }

  getTimeForHour(int hour) {
    final ent = List<MapEntry>.from(times.entries, growable: false);

    for(var i = 0; i < ent.length; i++) {
      if(!(hour >= ent[i].key)) {
        return entries[ent[i-1].value];
      }
    }
    return entries[ent[ent.length-1].value];
  }
}