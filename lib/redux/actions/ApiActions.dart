import 'package:flutter/cupertino.dart';
import 'package:lbp/data/Language.dart';
import 'package:lbp/data/general/SetLanguageRequest.dart';
import 'package:lbp/data/general/SetLanguageResponse.dart';
import 'package:lbp/data/setData/SetDataRequest.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/DaysRequest.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/data/login/LoginRequest.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/ValidationResponse.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/GeneralActions.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:redux/redux.dart';

import 'FetchAction.dart';

class ApiLoginAction extends ApiActionWithApiCall<AppState> {
  String username;
  String password;

  ApiLoginAction({@required this.username, @required this.password});

  @override
  void call(Store<AppState> store, NextDispatcher next) {
    next(SetInitUsernameAction(username));
    next(FetchDataAction<LoginData>(
        LoginRequest(username: username, password: password)));
  }
}

class ApiLoginActionSessKey extends ApiActionWithApiCall<AppState> {
  @override
  void call(Store<AppState> store, NextDispatcher next) {
    next(FetchDataAction<LoginData>(LoginRequestWithSessKey()));
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

class ApiSetLanguageAction extends ApiActionWithApiCall<AppState> {
  final Language language;

  ApiSetLanguageAction(this.language);

  @override
  void call(Store<AppState> store, next) {
    next(FetchDataAction<SetLanguageResponse>(SetLanguageRequest(
      language: language,
    )));
  }
}
