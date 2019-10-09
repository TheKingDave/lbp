import 'package:lbp/helpers.dart';

class Strings {
  static final strings = {};

  static String getString(String short) {
    return strings[short] ?? "?";
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
