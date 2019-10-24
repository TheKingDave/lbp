import 'package:lbp/data/strings/LessonStrings.dart';

import 'Strings.dart';

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

    Strings.lessons = LessonStrings.fromJson({
      "subject": ["Subject", "SUBJ"],
      "ger": ["German", "D"],
      "am": ["Mathematics", "AM"],
      "am2": ["Mathematics", "AM"],
      "eng": ["English", "E"],
      "sew": ["Software Development", "SEW"],
      "sew2": ["Software Development", "SEW"],
      "nwtk": ["Networking Technology", "NWTK"],
      "syte": ["System Technology Electronics", "SYTE"],
      "syteahit": ["System Technology Electronics (Only AHIT)", "SYTE"],
      "sytebhit": ["System Technology Electronics (Only BHIT)", "SYTE"],
      "syti": ["System Technology Computer Science ", "SYTI"],
      "sytit": ["System Technology Computer Science (Theory)", "SYTI"],
      "sytit2": ["System Technology Computer Science (Theory)", "SYTI"],
      "syt": ["System Technology", "SYT"],
      "syt2": ["System Technology", "SYT"],
      "syt3": ["System Technology", "SYT"],
      "itsi": ["IT Security", "ITSI"],
      "ai": ["AI / Data Science", "AI"],
      "insy": ["Information Systems", "INSY"],
      "itp": ["Projectmanagment", "ITP"],
      "nw": ["Natural Sciences", "NW"],
      "medt": ["Media technology", "MEDT"],
      "medt3d": ["3D & Game Development", "3DG"],
      "medtmm": ["Multimedia", "MM"],
      "medtweb": ["Web Development", "WE"],
      "es1": ["Energiesysteme", "ES"],
      "aiit": ["Informatik", "AIIT"],
      "aiit2": ["Informatik", "AIIT"],
      "amhet": ["Mathematics (ONLY HET!!!)", "AM (HET)"],
      "amhit": ["Mathematics (ONLY HIT!!!)", "AM (HIT)"]
    });
  }
}
