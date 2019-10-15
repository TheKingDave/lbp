import 'dart:convert';

import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/helpers.dart';

class ApiResponses {
  static final _constructors = {
    LoginData: (Map<String, dynamic> json) => LoginData.fromJson(json),
  };

  static ApiResponses create(Type type, Map<String, dynamic> json) {
    return _constructors[type](json);
  }
}

class ApiResponse<T extends ApiResponses> {

  String _error;
  T resp;

  ApiResponse.error(error) {
    this.error = error;
  }

  ApiResponse.ok(this.resp);

  ApiResponse.fromJson(Map<String, dynamic> parsedJson) {
    if(parsedJson.containsKey("err")) {
      error = parsedJson['err'];
    } else {
      resp = ApiResponses.create(T, parsedJson);
    }
  }

  factory ApiResponse.fromRawJson(String rawJson) {
    try {
      Map<String, dynamic> parsedJson = jsonDecode(rawJson);
      return ApiResponse<T>.fromJson(parsedJson);
    } on Exception catch(e) {
      cPrint("ApiResponse.fromRawJson " + e.toString());
      return ApiResponse<T>.error("UNKNOWN_ERROR");
    }
  }

  bool hasError() {
    return _error != null;
  }

  String get error => _error;

  set error(String value) {
    _error = Strings.getString(value, value);
  }

  @override
  String toString() {
    if(hasError()) {
      return "ApiResponse<$T>{error: $error}";
    } else {
      return "ApiResponse<$T>{resp: $resp}";
    }
  }

}