import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/DaysRequest.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:redux/redux.dart';

class LoginRequest extends ApiRequest {
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

  @override
  String getEndpoint() {
    return "login";
  }

  @override
  String toString() {
    return 'LoginRequest{username: $username, password: <hidden>}';
  }

  void onSuccess(Store<AppState> store, NextDispatcher next) {
    store.dispatch(FetchDataAction<Days>(
        DaysRequest(sess_key: store.state.login.data.sessionKey)));
    next(NavigateReplaceAction(RouteNames.overview));
  }
}
