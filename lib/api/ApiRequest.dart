import 'dart:convert';

import 'package:lbp/redux/AppState.dart';
import 'package:redux/redux.dart';

abstract class ApiRequest {

  Map<String, String> getHeaders() => const {"content-type": "application/json"};
  Encoding getEncoding() => null;
  String getEndpoint();
  String getBody();

  void onSuccess(Store<AppState> store, NextDispatcher next) {}
  void onFailure(Store<AppState> store, NextDispatcher next) {}

}