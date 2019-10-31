import 'package:lbp/data/strings/DayTimeStrings.dart';
import 'package:lbp/data/strings/LessonStrings.dart';

class Strings {
  static const dayTimesKey = "dayTimes";
  static const lessonsKey = "subject";

  static final Map<String, String> strings = {};
  static LessonStrings lessons = LessonStrings();
  static DayTimeStrings dayTimes = DayTimeStrings();

  static String getString(String short, [def = "?"]) {
    return strings[short] ?? def;
  }

  static String capitalize(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  static String getCapitalize(String short) {
    return capitalize(Strings.getString(short));
  }

  static void addString(String short, String string, [allowApp = false]) {
    if((!allowApp) && short.startsWith("a_")) return;
    if(!Strings.strings.containsKey(short)) Strings.setString(short, string, allowApp);
  }

  static void setString(String short, String string, [allowApp = false]) {
    if((!allowApp) && short.startsWith("a_")) return;
    strings[short] = string;
  }

  static void addMany(Map<String, String> strings) {
    strings.forEach((k, v) =>
        Strings.strings.containsKey(k) ? null : Strings.strings[k] = v);
  }

  static void overrideMany(Map<String, String> strings) {
    strings.forEach((k, v) => Strings.strings[k] = v);
  }

  static const Map<int, String> numberWeekdayMap = {
    1: "monday",
    2: "tuesday",
    3: "wednesday",
    4: "thursday",
    5: "friday",
  };

  static String getWeekdayString(int weekday) {
    return getCapitalize(numberWeekdayMap[weekday]);
  }

  static String getGreetingString(int hour) {
    return "${capitalize(dayTimes.getGood())} ${capitalize(Strings.dayTimes.getTimeForHour(hour))}";
  }

  static void setFromJson(Map<String, dynamic> json, [allowApp = false]) {
    if(json.containsKey(dayTimesKey)) {
      Strings.dayTimes = DayTimeStrings.fromJson(json[dayTimesKey]);
      json.remove(dayTimesKey);
    }
    if(json.containsKey(lessonsKey)) {
      Strings.lessons = LessonStrings.fromJson(json[lessonsKey]);
      json.remove(lessonsKey);
    }
    json.forEach((short, string) {
      if(string is String) {
        Strings.setString(short, string, allowApp);
      }
    });
  }
}
