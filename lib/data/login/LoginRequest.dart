import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiRequestWithKey.dart';
import 'package:lbp/etc/helpers.dart';

class LoginRequest extends ApiRequest {
  String username;
  String password;

  LoginRequest({@required this.username, @required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = encode(this.username);
    data['password'] = encode(this.password);
    return data;
  }

  @override
  String getBody() {
    return jsonEncode(this.toJson());
  }

  @override
  String getEndpoint() {
    return "login";
  }

  @override
  String toString() {
    return 'LoginRequest{username: $username, password: <hidden>}';
  }
}

class LoginRequestWithSessKey extends ApiRequestWithKey {
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
    return "getLoginData";
  }

  @override
  String toString() {
    return 'LoginRequestWithSessKey{sessKey: <hidden>}';
  }
}
