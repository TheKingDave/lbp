import 'package:lbp/redux/actions/SetSessKeyAction.dart';
import 'package:redux/redux.dart';

final Reducer<String> sessKeyReducer = combineReducers<String>([
  TypedReducer<String, SetSessKeyAction>(_setSessKey),
]);

String _setSessKey(String state, SetSessKeyAction action) {
  return action.sessKey;
}