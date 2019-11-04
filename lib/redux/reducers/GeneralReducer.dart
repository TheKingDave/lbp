import 'package:lbp/data/general/GeneralData.dart';
import 'package:lbp/redux/actions/GeneralActions.dart';
import 'package:redux/redux.dart';

final Reducer<GeneralData> generalReducer = combineReducers<GeneralData>([
  TypedReducer<GeneralData, SetSessKeyAction>(_setSessKey),
  TypedReducer<GeneralData, SetInitUsernameAction>(_setInitUsername),
  TypedReducer<GeneralData, SetDarkModeAction>(_setDarkMode),
  TypedReducer<GeneralData, SetLanguageAction>(_setLanguage),
]);

GeneralData _setSessKey(GeneralData state, SetSessKeyAction action) {
  return state.copyWith(sessKey: action.sessKey);
}

GeneralData _setInitUsername(GeneralData state, SetInitUsernameAction action) {
  return state.copyWith(initUsername: action.initUsername);
}

GeneralData _setDarkMode(GeneralData state, SetDarkModeAction action) {
  return state.copyWith(darkMode: action.darkMode);
}

GeneralData _setLanguage(GeneralData state, SetLanguageAction action) {
  return state.copyWith(language: action.language);
}