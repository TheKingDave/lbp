import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/reducers/ErrorReducers.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';
import 'package:lbp/redux/reducers/UserReducers.dart';

AppState rootReducer(AppState state, action) => AppState(
  login: fetchReducer<LoginData>(state.login, action, userReducer),
  error: errorReducer(state.error, action),
  config: state.config,
);