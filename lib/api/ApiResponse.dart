import 'package:lbp/api/login/LoginRespsone.dart';
import 'package:lbp/api/strings/Strings.dart';
import 'package:lbp/helpers.dart';

class ApiResponses {
  static final _constructors = {
    LoginResponse: (Map<String, dynamic> json) => LoginResponse.fromJson(json),
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

  bool get hasError {
    return _error != null;
  }

  String get error => _error;

  set error(String value) {
    _error = Strings.getString(value, value);
  }

  @override
  String toString() {
    if(hasError) {
      return "ApiResponse<$T>{error: $error}";
    } else {
      return "ApiResponse<$T>{resp: $resp}";
    }
  }

}