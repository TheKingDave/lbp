import 'package:lbp/data/strings/LessonStrings.dart';

class Strings {
  static final Map<String, String> strings = {};
  static LessonStrings lessons = LessonStrings();

  static String getString(String short, [def = "?"]) {
    return strings[short] ?? def;
  }

  static String getCapitalize(String short) {
    final s = Strings.getString(short);
    return '${s[0].toUpperCase()}${s.substring(1)}';
  }

  static void setString(String short, String string) {
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
}
