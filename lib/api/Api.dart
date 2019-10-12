import 'package:lbp/api/ApiData.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/login/LoginRequest.dart';
import 'package:lbp/api/requests/PostRequest.dart';
import 'package:lbp/data/LoginData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static final Api _api = new Api();

  static final _requests = {
    "login": PostRequest<LoginData, LoginRequest>(),
  };

  static Api get() {
    return _api;
  }

  final Map<ApiData, ApiResponses> data = {};
  SharedPreferences settings;

  init() async {
    settings = await SharedPreferences.getInstance();
    // TODO: remove clear
    settings.clear();
  }

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

  Future<ApiResponse<LoginData>> login(LoginRequest req) async {
    final res = await _requests['login'].send(req);
    setData(ApiData.loginData, res);
    return res;
  }

  bool isLoggedIn() {
    return existData(ApiData.loginData);
  }

}
