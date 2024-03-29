import 'dart:convert';

import 'package:lbp/api/ApiRequestWithKey.dart';
import 'package:lbp/data/Language.dart';
import 'package:lbp/etc/Constants.dart';

class SetLanguageRequest extends ApiRequestWithKey {
  Language language;

  SetLanguageRequest({this.language});

  Map<String, dynamic> toJson() {
    return {
      "lang": language.short,
      "sess_key": sessKey,
    };
  }

  @override
  String getBody() {
    return jsonEncode(this.toJson());
  }

  @override
  String getEndpoint() {
    return Constants.api_path_set_lang;
  }

}