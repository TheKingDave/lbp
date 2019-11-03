import 'dart:convert';

import 'package:lbp/api/ApiRequestWithKey.dart';
import 'package:lbp/etc/Constants.dart';

class SetDarkModeRequest extends ApiRequestWithKey {
  bool darkMode;

  SetDarkModeRequest({this.darkMode});

  Map<String, dynamic> toJson() {
    return {
      "theme": darkMode ? Constants.theme_dark : Constants.theme_light,
      "sess_key": sessKey,
    };
  }

  @override
  String getBody() {
    return jsonEncode(this.toJson());
  }

  @override
  String getEndpoint() {
    return Constants.api_path_set_theme;
  }

}