import 'dart:convert';

import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/helpers.dart';

class ApiResponses {
  static final Map<dynamic, Function(Map<String, dynamic>)> _constructorsMap = {
    LoginData: (Map<String, dynamic> json) => LoginData.fromJson(json),
    Class: (Map<String, dynamic> json) => Class.fromJson(json),
  };

  static final Map<dynamic, Function(List<dynamic> json)> _constructorsList = {
    Days: (List<dynamic> json) => Days.fromJson(json),
  };

  static ApiResponses createMap(Type type, Map<String, dynamic> json) {
    return _constructorsMap[type](json);
  }

  static ApiResponses createList(Type type, List<dynamic> json) {
    return _constructorsList[type](json);
  }
}

class ApiResponse<T extends ApiResponses> {
  String _error;
  T resp;

  ApiResponse.error(error) {
    this.error = error;
  }

  ApiResponse.ok(this.resp);

  ApiResponse.fromJson(dynamic parsedJson) {
    if (parsedJson is Map<String, dynamic>) {
      parsedJson = parsedJson as Map<String, dynamic>;
      if (parsedJson.containsKey("err")) {
        error = parsedJson['err'];
      } else {
        resp = ApiResponses.createMap(T, parsedJson);
      }
    } else if (parsedJson is List<dynamic>) {
      parsedJson = parsedJson as List<dynamic>;
      resp = ApiResponses.createList(T, parsedJson);
    }
  }

  factory ApiResponse.fromRawJson(String rawJson) {
    try {
      dynamic parsedJson = jsonDecode(rawJson);
      return ApiResponse<T>.fromJson(parsedJson);
    } on Exception catch (e) {
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
    if (hasError()) {
      return "ApiResponse<$T>{error: $error}";
    } else {
      return "ApiResponse<$T>{resp: $resp}";
    }
  }
}
