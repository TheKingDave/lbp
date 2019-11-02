import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:redux/redux.dart';

final Reducer<LoginData> userReducer = combineReducers<LoginData>([
  TypedReducer<LoginData, SetLanguageAction>(_setLanguageReducer),
]);

final _setLanguageReducer = (LoginData state, SetLanguageAction action) =>
    LoginData.copy(state, language: action.value.short);
