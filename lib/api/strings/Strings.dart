import 'package:lbp/helpers.dart';

class Strings {
  static final Map<String, String> strings = {};

  static String getString(String short) {
    return strings[short] ?? "?";
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
}
