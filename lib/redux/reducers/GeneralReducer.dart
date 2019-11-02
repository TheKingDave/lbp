import 'package:lbp/data/GeneralData.dart';
import 'package:lbp/redux/actions/GeneralActions.dart';
import 'package:redux/redux.dart';

final Reducer<GeneralData> generalReducer = combineReducers<GeneralData>([
  TypedReducer<GeneralData, SetSessKeyAction>(_setSessKey),
  TypedReducer<GeneralData, SetInitUsernameAction>(_setInitUsername),
]);

GeneralData _setSessKey(GeneralData state, SetSessKeyAction action) {
  return state.copyWith(sessKey: action.sessKey);
}

GeneralData _setInitUsername(GeneralData state, SetInitUsernameAction action) {
  return state.copyWith(initUsername: action.initUsername);
}