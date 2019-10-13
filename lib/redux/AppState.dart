import 'package:lbp/data/LoginData.dart';
import 'package:lbp/redux/states/FetchState.dart';

class AppState {
  final FetchState<LoginData> login;
  final Exception error;

  AppState({
    this.login,
    this.error,
  });

  factory AppState.initial() =>
      AppState(login: FetchState<LoginData>.initial(), error: null);
}
