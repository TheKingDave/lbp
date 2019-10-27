import 'dart:convert';
import 'package:lbp/api/ApiRequestWithKey.dart';

class DaysRequest extends ApiRequestWithKey {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sess_key'] = this.sessKey;
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