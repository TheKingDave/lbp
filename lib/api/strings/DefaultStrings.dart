import 'package:lbp/api/strings/Strings.dart';

class DefaultStrings {
  static void setDefaultString() {
    const strings = {
      "username": "username",
      "password": "password",
      "login": "login",
    };

    Strings.overrideMany(strings);
  }
}
