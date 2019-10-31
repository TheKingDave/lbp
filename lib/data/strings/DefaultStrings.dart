import 'dart:convert';

import 'package:flutter/services.dart';

import 'Strings.dart';

class DefaultStrings {
  static setDefaultString() async {
    Strings.setFromJson(
        jsonDecode(await rootBundle.loadString("assets/lang/en.json")), true);
  }
}
