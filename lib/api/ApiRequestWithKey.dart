import 'dart:convert';

import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:redux/redux.dart';

abstract class ApiRequestWithKey extends ApiRequest {
  String sessKey;

  Map<String, String> getHeaders() => const {"content-type": "application/json"};
  Encoding getEncoding() => null;
  String getEndpoint();
  String getBody();

  void onSuccess(Store<AppState> store, NextDispatcher next) {}
  void onFailure(Store<AppState> store, NextDispatcher next) {}

  void setSesKey(String sessKey) {
    this.sessKey = sessKey;
  }

}