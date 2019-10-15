class ConfigState {

  final String webUrl;
  final String apiUrl;

  ConfigState({this.webUrl, this.apiUrl});

  factory ConfigState.initial() =>
      ConfigState(webUrl: "https://lb-planer.tgm.ac.at", apiUrl: "api/v1/");

}