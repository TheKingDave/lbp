import 'package:flutter/cupertino.dart';
import 'package:lbp/data/login/LoginRequest.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:redux/redux.dart';

import 'FetchAction.dart';

class ApiLoginAction extends ApiActionWithApiCall<AppState> {
  String username;
  String password;

  ApiLoginAction({@required this.username, @required this.password});

  @override
  void call(Store<AppState> store, NextDispatcher next) {
    next(FetchDataAction<LoginData, LoginRequest>(
        LoginRequest(username: username, password: password)));
  }
}
