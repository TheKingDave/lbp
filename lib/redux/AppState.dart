import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/redux/states/ConfigState.dart';
import 'package:lbp/redux/states/FetchState.dart';

class AppState {
  final FetchState<LoginData> login;
  final FetchState<Days> days;
  final Exception error;
  final ConfigState config;

  AppState({
    this.login,
    this.days,
    this.error,
    this.config,
  });

  factory AppState.initial() => AppState(
      login: FetchState<LoginData>.initial(),
      days: FetchState<Days>.initial(),
      error: null,
      config: ConfigState.initial());
}
