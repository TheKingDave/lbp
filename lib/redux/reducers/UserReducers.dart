import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/redux/actions/SetSessKeyAction.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:redux/redux.dart';

final Reducer<LoginData> userReducer = combineReducers<LoginData>([
  TypedReducer<LoginData, SetLanguageAction>(_setLanguageReducer),
  TypedReducer<LoginData, SetDarkModeAction>(_setDarkModeReducer),
]);

final _setLanguageReducer = (LoginData state, SetLanguageAction action) =>
    LoginData.copy(state, language: action.value.short);

final _setDarkModeReducer = (LoginData state, SetDarkModeAction action) =>
    LoginData.copy(state, darkMode: action.value);
