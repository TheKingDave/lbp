import 'package:lbp/data/LoginData.dart';
import 'package:lbp/redux/states/FetchState.dart';

class AppState {
  static final initial = AppState(FetchState.initial<LoginData>());

  final FetchState<LoginData> login;

  AppState(this.login);

}