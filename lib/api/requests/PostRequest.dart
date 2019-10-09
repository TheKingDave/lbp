import 'dart:convert';

import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/requests/Request.dart';
import 'package:http/http.dart' as http;

import '../../helpers.dart';
import '../Api.dart';

class PostRequest<T extends ApiResponses, S extends ApiRequest>
    implements Request {
  String url;
  Map<String, String> headers;
  Encoding encoding;

  PostRequest(this.url, {this.headers, this.encoding});

  @override
  Future<ApiResponse<ApiResponses>> send([ApiRequest req]) async {
    http.Response res;
    try {
      res = await http.post(Api.get().getApiUrl(url),
          headers: headers, body: req?.getBody(), encoding: encoding);
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

/*
http.Response res;
    try {
      res = await http.post(Api.get().getApiUrl(url),
          headers: headers, body: body, encoding: encoding);
    } on Exception catch (e) {
      cPrint(e.toString());
      return ApiResponse<T>.error("network_err");
    }

    if (res.statusCode != 200) {
      cPrint("Wrong status code. ${res.statusCode}");
      return ApiResponse<T>.error("network_err");
    }

    return ApiResponse<T>.fromRawJson(res.body);
  }
 */
