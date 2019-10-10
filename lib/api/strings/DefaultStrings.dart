import 'package:lbp/api/strings/Strings.dart';

class DefaultStrings {
  static void setDefaultString() {
    const strings = {
      "username": "username",
      "password": "password",
      "login": "login",
      "LOGIN_FAILED": "Login failed, check your username and password again 🤔",
      "LOGIN_FAILED_SERVER_SIDE":
          "The server isn't able to connect to the authentication service 🤬",
      "LOGIN_FAILED_NOT_AUTHORIZED": "You are not authorized to login 😓",
      "UNKNOWN_ERROR": "An unknown error has occurred",
      "network_err": "Network error",
      "monday": "monday",
      "tuesday": "tuesday",
      "wednesday": "wednesday",
      "thursday": "thursday",
      "friday": "friday",
    };

    Strings.overrideMany(strings);
  }
}
