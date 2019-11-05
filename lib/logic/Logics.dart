import 'package:lbp/data/Language.dart';
import 'package:lbp/data/general/SetDarkModeRequest.dart';
import 'package:lbp/data/general/SetLanguageRequest.dart';
import 'package:lbp/data/general/SetLanguageResponse.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/ValidationResponse.dart';
import 'package:lbp/data/note/SetNoteResponse.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/Constants.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/actions/ForceReloadAction.dart';
import 'package:lbp/redux/actions/InitAction.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:lbp/redux/actions/GeneralActions.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/middleware/LogicMiddleware.dart';
import 'package:lbp/redux/selectors/GeneralSelectors.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RouteNames.dart';

final List<Logic> logics = [
  TypedLogic<AppState, FetchActionSuccess<LoginData>>(_loginSuccessLogic),
  TypedLogic<AppState, FetchActionSuccess<SetDataResponse>>(
      _setDataSuccessLogic),
  TypedLogic<AppState, LogoutAction>(_logout),
  TypedLogic<AppState, SetLanguageAction>(_updateLanguage),
  TypedLogic<AppState, FetchActionSuccess<SetLanguageResponse>>(
      _updateLanguageFromApi),
  TypedLogic<AppState, GeneralAction>(_saveGeneralSetting),
  TypedLogic<AppState, GeneralAction>(_syncGeneralSetting),
];

void _loginSuccessLogic(Store<AppState> store, NextDispatcher next,
    FetchActionSuccess<LoginData> action) {
  if (action.data.sessionKey != null) {
    store.dispatch(SetSessKeyAction(action.data.sessionKey));
  }

  store.dispatch(SetDarkModeAction(action.data.darkMode));
  store.dispatch(SetLanguageAction(Language(action.data.language)));

  if (action.data.ldClass == Constants.teacherClass) {
    // get teacher data
    next(NavigateReplaceAction(RouteNames.teacherOverview));
  } else {
    store.dispatch(ApiGetDataAction());
    next(NavigateReplaceAction(RouteNames.studentOverview));
  }
}

void _setDataSuccessLogic(Store<AppState> store, NextDispatcher next,
    FetchActionSuccess<ValidationResponse> action) {
  store.dispatch(ApiGetDataAction());
  if(overviewReturnSelector(store.state)) {
    next(NavigatePushAction(RouteNames.studentOverview));
  }
}

void _logout(Store<AppState> store, NextDispatcher next, action) {
  SharedPreferences.getInstance().then((sp) {
    sp.remove(Constants.sp_username);
    sp.remove(Constants.sp_sess_key);
    sp.remove(Constants.sp_language);
    sp.remove(Constants.sp_dark_mode);
    sp.remove(Constants.sp_overview_return);
  });
  next(NavigatePushNamedAndRemoveUntilAction(RouteNames.login));
  next(InitAction());
}

void _saveGeneralSetting(
    Store<AppState> store, NextDispatcher next, GeneralAction action) {
  SharedPreferences.getInstance().then((sp) {
    if (action is SetInitUsernameAction) {
      sp.setString(Constants.sp_username, action.initUsername);
    } else if (action is SetSessKeyAction) {
      sp.setString(Constants.sp_sess_key, action.sessKey);
    } else if (action is SetDarkModeAction) {
      sp.setBool(Constants.sp_dark_mode, action.darkMode);
    } else if (action is SetLanguageAction) {
      sp.setString(Constants.sp_language, action.language.short);
    } else if (action is SetOverviewReturnAction) {
      sp.setBool(Constants.sp_overview_return, action.overviewReturn);
    }
  });
}

void _syncGeneralSetting(
    Store<AppState> store, NextDispatcher next, GeneralAction action) {
  if (action is SetDarkModeAction) {
    store.dispatch(FetchDataAction<ValidationResponse>(
        SetDarkModeRequest(darkMode: action.darkMode)));
  } else if (action is SetLanguageAction) {
    store.dispatch(ApiSetLanguageAction(action.language));
  }
}

void _updateLanguage(
    Store<AppState> store, NextDispatcher next, SetLanguageAction action) {
  Strings.loadFromAssets(action.language);
  next(ForceReloadAction());
}

void _updateLanguageFromApi(Store<AppState> store, NextDispatcher next,
    FetchActionSuccess<SetLanguageResponse> action) {
  Strings.setFromJson(action.data.json);
  next(ForceReloadAction());
}
