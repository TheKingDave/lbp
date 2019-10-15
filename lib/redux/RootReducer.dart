import 'package:lbp/data/LoginData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/reducers/ErrorReducers.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';

AppState rootReducer(AppState state, action) => AppState(
  login: fetchReducer<LoginData>(state.login, action),
  error: errorReducer(state.error, action),
  config: state.config,
);