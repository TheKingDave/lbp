import 'package:lbp/data/GeneralData.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/ValidationResponse.dart';
import 'package:lbp/redux/states/ConfigState.dart';
import 'package:lbp/redux/states/FetchState.dart';

class AppState {
  final FetchState<LoginData> login;
  final FetchState<Days> days;
  final FetchState<ValidationResponse> setData;
  final GeneralData general;
  final Exception error;
  final ConfigState config;

  AppState({
    this.login,
    this.days,
    this.setData,
    this.general,
    this.error,
    this.config,
  });

  static initial() async {
    return AppState(
        login: FetchState<LoginData>.initial(),
        days: FetchState<Days>.initial(),
        setData: FetchState<ValidationResponse>.initial(),
        general: await GeneralData.initial(),
        error: null,
        config: ConfigState.initial());
  }
}
