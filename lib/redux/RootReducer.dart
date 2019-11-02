import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/InitAction.dart';
import 'package:lbp/redux/reducers/ErrorReducers.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';
import 'package:lbp/redux/reducers/SessKeyReducer.dart';
import 'package:lbp/redux/reducers/UserReducers.dart';

AppState rootReducer(AppState state, action) {
  if(action is InitAction) {
    return AppState.initial();
  } else {
    return AppState(
      login: fetchReducer<LoginData>(state.login, action, userReducer),
      days: fetchReducer<Days>(state.days, action),
      setData: fetchReducer<SetDataResponse>(state.setData, action),
      sessKey: sessKeyReducer(state.sessKey, action),
      error: errorReducer(state.error, action),
      config: state.config,
    );
  }
}