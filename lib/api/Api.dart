import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/login/LoginRespsone.dart';

class Api {
  static final Api _api = new Api();

  static Api get() {
    return _api;
  }

  String getApiUrl([String extension = ""]) {
    return "https://lb-planer.tgm.ac.at/api/v1/$extension";
  }

  ApiResponse<LoginResponse> login (String username, String password) {
    return login(username, password);
  }

}