import 'dart:convert';

import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/login/LoginRequest.dart';
import 'package:lbp/api/requests/PostRequest.dart';
import 'package:lbp/api/login/LoginRespsone.dart';

import '../helpers.dart';

class Api {
  static final Api _api = new Api();

  static final _requests = {
    "login": PostRequest<LoginResponse, LoginRequest>("login",
        headers: {"content-type": "application/json"}),
  };

  static Api get() {
    return _api;
  }

  String getApiUrl([String extension = ""]) {
    return "https://lb-planer.tgm.ac.at/api/v1/$extension";
    //return "http://redt6a.thekingdave.com:3001/api/v1/$extension";
  }

  Future<ApiResponse<LoginResponse>> login(LoginRequest req) async {
    return await _requests['login'].send(req);
  }
}
