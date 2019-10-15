import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/redux/states/ConfigState.dart';
import 'package:lbp/redux/states/FetchState.dart';

class AppState {
  final FetchState<LoginData> login;
  final Exception error;
  final ConfigState config;

  AppState({
    this.login,
    this.error,
    this.config,
  });

  factory AppState.initial() => AppState(
      login: FetchState<LoginData>.initial(),
      error: null,
      config: ConfigState.initial());
}
