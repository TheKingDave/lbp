import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/etc/Constants.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/actions/InitAction.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:lbp/redux/actions/SetSessKeyAction.dart';
import 'package:lbp/redux/actions/SetUsernameAction.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/middleware/LogicMiddleware.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RouteNames.dart';

final List<Logic> logics = [
  TypedLogic<AppState, FetchActionSuccess<LoginData>>(_loginSuccessLogic),
  TypedLogic<AppState, FetchActionSuccess<SetDataResponse>>(_setDataSuccessLogic),
  TypedLogic<AppState, LogoutAction>(_logout),
  TypedLogic<AppState, SetUsernameAction>(_login),
];

void _loginSuccessLogic(Store<AppState> store, NextDispatcher next,
    FetchActionSuccess<LoginData> action) {

  if(action.data.sessionKey != null) {
    next(SetSessKeyAction(action.data.sessionKey));
  }

  SharedPreferences.getInstance().then((sp) {
    sp.setString(Constants.sp_sess_key, action.data.sessionKey);
  });

  if(action.data.ldClass == Constants.teacherClass) {
    // get teacher data
    next(NavigateReplaceAction(RouteNames.teacherOverview));
  } else {
    store.dispatch(ApiGetDataAction());
    next(NavigateReplaceAction(RouteNames.studentOverview));
  }
}

void _setDataSuccessLogic(Store<AppState> store, NextDispatcher next,
    FetchActionSuccess<SetDataResponse> action) {
  store.dispatch(ApiGetDataAction());
}

void _logout(Store<AppState> store, NextDispatcher next, action) {
  next(NavigatePushNamedAndRemoveUntilAction(RouteNames.login));
  next(InitAction());
}

void _login(Store<AppState> store, NextDispatcher next, SetUsernameAction action) {
  SharedPreferences.getInstance().then((sp) {
    sp.setString(Constants.sp_username, action.username);
  });
}
