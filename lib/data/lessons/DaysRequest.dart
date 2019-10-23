import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:redux/redux.dart';

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

  void onSuccess(Store<AppState> store, NextDispatcher next) {
    cPrint("Success ${store.state.days.data.days.length}");
  }


}