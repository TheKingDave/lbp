import 'package:lbp/api/ApiData.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/login/LoginRequest.dart';
import 'package:lbp/api/requests/PostRequest.dart';
import 'package:lbp/api/login/LoginRespsone.dart';

class Api {
  static final Api _api = new Api();

  static final _requests = {
    "login": PostRequest<LoginResponse, LoginRequest>("login",
        headers: {"content-type": "application/json"}),
  };

  static Api get() {
    return _api;
  }

  final Map<ApiData, ApiResponses> data = {};

  void setData(ApiData dataName, ApiResponse response) {
    if(!response.hasError()) {
      data[dataName] = response.resp;
    }
  }

  dynamic getData(ApiData dataName) {
    return data[dataName];
  }

  bool existData(ApiData dataName) {
    return data.containsKey(dataName);
  }

  String getUrl([String extension = ""]) {
    return "https://lb-planer.tgm.ac.at/$extension";
  }

  String getApiUrl([String extension = ""]) {
    return "${getUrl()}api/v1/$extension";
    //return "http://redt6a.thekingdave.com:3001/api/v1/$extension";
  }

  Future<ApiResponse<LoginResponse>> login(LoginRequest req) async {
    final res = await _requests['login'].send(req);
    setData(ApiData.loginData, res);
    return res;
  }

  bool isLoggedIn() {
    return existData(ApiData.loginData);
  }

}
