import 'dart:convert';

abstract class ApiRequest {

  Map<String, String> getHeaders() => const {"content-type": "application/json"};
  Encoding getEncoding() => null;
  String getEndpoint();
  String getBody();

}