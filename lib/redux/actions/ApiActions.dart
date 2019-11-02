import 'package:flutter/cupertino.dart';
import 'package:lbp/data/setData/SetDataRequest.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/DaysRequest.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/data/login/LoginRequest.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/SetSessKeyAction.dart';
import 'package:lbp/redux/actions/SetUsernameAction.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:redux/redux.dart';

import 'FetchAction.dart';

class ApiLoginAction extends ApiActionWithApiCall<AppState> {
  String username;
  String password;

  ApiLoginAction({@required this.username, @required this.password});

  @override
  void call(Store<AppState> store, NextDispatcher next) {
    next(SetUsernameAction(username));
    next(FetchDataAction<LoginData>(
        LoginRequest(username: username, password: password)));
  }
}

class ApiLoginActionSessKey extends ApiActionWithApiCall<AppState> {
  final String sessKey;

  ApiLoginActionSessKey(this.sessKey);

  @override
  void call(Store<AppState> store, NextDispatcher next) {
    next(SetSessKeyAction(sessKey));
    next(FetchDataAction<LoginData>(
        LoginRequestWithSessKey()));
  }
}

class ApiGetDataAction extends ApiActionWithApiCall<AppState> {
  @override
  void call(Store<AppState> store, next) {
    next(FetchDataAction<Days>(DaysRequest()));
  }
}

class ApiSetDataAction extends ApiActionWithApiCall<AppState> {
  String subject;
  TimeFrame period;

  ApiSetDataAction({@required this.subject, @required this.period});

  @override
  void call(Store<AppState> store, next) {
    next(FetchDataAction<SetDataResponse>(SetDataRequest(
      subject: subject,
      begin: period.begin,
      end: period.end,
    )));
  }

}
