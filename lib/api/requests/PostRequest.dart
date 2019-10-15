import 'package:http/http.dart' as http;
import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/requests/Request.dart';
import 'package:lbp/settings/Api.dart';

import '../../etc/helpers.dart';

class PostRequest<T extends ApiResponses, S extends ApiRequest>
    implements Request {
  @override
  Future<ApiResponse<T>> send(ApiRequest req) async {
    http.Response res;
    try {
      res = await http.post(Api.getApiUrl(req.getEndpoint()),
          headers: req.getHeaders(),
          body: req?.getBody(),
          encoding: req.getEncoding());
    } on Exception catch (e) {
      cPrint("${this} " + e.toString());
      return ApiResponse<T>.error("network_err");
    }

    if (res.statusCode != 200) {
      cPrint("${this} Wrong status code. ${res.statusCode}");
      return ApiResponse<T>.error("network_err");
    }

    return ApiResponse<T>.fromRawJson(res.body);
  }
}
