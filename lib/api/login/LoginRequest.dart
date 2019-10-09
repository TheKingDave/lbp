import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/helpers.dart';

class LoginRequest implements ApiRequest {
  String username;
  String password;

  LoginRequest({@required this.username, @required this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

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
}
