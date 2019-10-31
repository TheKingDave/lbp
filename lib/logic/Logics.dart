import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/actions/InitAction.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/middleware/LogicMiddleware.dart';
import 'package:redux/redux.dart';

import '../RouteNames.dart';

final List<Logic> logics = [
  TypedLogic<AppState, FetchActionSuccess<LoginData>>(_loginSuccessLogic),
  TypedLogic<AppState, FetchActionSuccess<SetDataResponse>>(_setDataSuccessLogic),
  TypedLogic<AppState, LogoutAction>(_logout),
];

void _loginSuccessLogic(Store<AppState> store, NextDispatcher next,
    FetchActionSuccess<LoginData> action) {

  if(action.data.isTeacher) {
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