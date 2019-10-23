import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lbp/api/ApiRequest.dart';

class DaysRequest extends ApiRequest {
  String sess_key;

  DaysRequest({@required this.sess_key});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sess_key'] = this.sess_key;
    return data;
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