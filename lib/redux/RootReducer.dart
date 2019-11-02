import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/ValidationResponse.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/InitAction.dart';
import 'package:lbp/redux/reducers/ErrorReducers.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';
import 'package:lbp/redux/reducers/GeneralReducer.dart';
import 'package:lbp/redux/reducers/UserReducers.dart';

AppState rootReducer(AppState state, action) {
  if(action is InitAction) {
    return AppState.initial();
  } else {
    return AppState(
      login: fetchReducer<LoginData>(state.login, action, userReducer),
      days: fetchReducer<Days>(state.days, action),
      setData: fetchReducer<ValidationResponse>(state.setData, action),
      general: generalReducer(state.general, action),
      error: errorReducer(state.error, action),
      config: state.config,
    );
  }
}