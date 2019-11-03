import 'package:lbp/etc/Constants.dart';

class ConfigState {

  final String webUrl;
  final String apiUrl;

  ConfigState({this.webUrl, this.apiUrl});

  factory ConfigState.initial() =>
      ConfigState(webUrl: Constants.api_web_url, apiUrl: Constants.api_url);

}