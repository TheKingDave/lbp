import 'dart:convert';

import 'package:lbp/api/ApiRequestWithKey.dart';

class SetDataRequest extends ApiRequestWithKey {
  DateTime begin;
  DateTime end;
  String subject;

  SetDataRequest({this.begin, this.end, this.subject});

  Map<String, dynamic> toJson() {
    return {
      "begin": begin.toIso8601String(),
      "end": end.toIso8601String(),
      "subject": subject,
      "sess_key": sessKey,
    };
  }

  @override
  String getBody() {
    return jsonEncode(this.toJson());
  }

  @override
  String getEndpoint() {
    return "getData";
  }

}