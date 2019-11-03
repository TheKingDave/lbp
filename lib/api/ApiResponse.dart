import 'dart:convert';

import 'package:lbp/data/general/SetLanguageResponse.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/ValidationResponse.dart';
import 'package:lbp/data/note/SetNoteResponse.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/helpers.dart';

class ApiResponses {
  static final Map<dynamic, Function(Map<String, dynamic>)> _constructorsMap = {
    LoginData: (json) => LoginData.fromJson(json),
    Class: (json) => Class.fromJson(json),
    ValidationResponse: (json) => ValidationResponse.fromJson(json),
    SetDataResponse: (json) => SetDataResponse.fromJson(json),
    SetLanguageResponse: (json) => SetLanguageResponse.fromJson(json),
    SetNoteResponse: (json) => SetNoteResponse.fromJson(json),
  };

  static final Map<dynamic, Function(List<dynamic> json)> _constructorsList = {
    Days: (json) => Days.fromJson(json),
  };

  static ApiResponses createMap(Type type, Map<String, dynamic> json) {
    if(_constructorsMap.containsKey(type)) {
      return _constructorsMap[type](json);
    } else {
      throw Exception("$type is not defined in the mapping list (Map)");
    }
  }

  static ApiResponses createList(Type type, List<dynamic> json) {
    if(_constructorsList.containsKey(type)) {
      return _constructorsList[type](json);
    } else {
      throw Exception("$type is not defined in the mapping list (List)");
    }
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
