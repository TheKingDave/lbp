import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/login/LoginRespsone.dart';
import 'package:lbp/helpers.dart';

Future<ApiResponse<LoginResponse>> login(String username, String password) async {
  final sendObj = {
    "username": encode(username),
    "password": encode(password),
  };

  var res;

  try {
    res = await http.post(Api.get().getApiUrl("login"),
        body: sendObj);
  } on Exception catch(e) {
    cPrint(e.toString());
    return ApiResponse<LoginResponse>.error("network_err");
  }

  if(res.statusCode != 200) {
    return ApiResponse<LoginResponse>.error("network_err");
  }

  return ApiResponse<LoginResponse>.fromJson(jsonDecode(res.body));
}