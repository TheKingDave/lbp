import 'package:lbp/data/LoginData.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:redux/redux.dart';

final Reducer<LoginData> userReducer = combineReducers<LoginData>([
  TypedReducer<LoginData, SetLanguageAction>(_setLanguageReducer),
  TypedReducer<LoginData, SetDarkModeAction>(_setDarkModeReducer)
]);

final _setLanguageReducer = (LoginData state, SetLanguageAction action) =>
    LoginData.fromOther(state, language: action.value);

final _setDarkModeReducer = (LoginData state, SetDarkModeAction action) =>
    LoginData.fromOther(state, darkMode: action.value);
