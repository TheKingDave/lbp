import 'package:lbp/api/strings/Strings.dart';

class DefaultStrings {
  static void setDefaultString() {
    const strings = {
      "username": "Username",
      "password": "Password",
      "login": "Login",
    };

    Strings.overrideMany(strings);
  }
}
