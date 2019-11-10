import 'package:lbp/redux/actions/ResetFeedbackActions.dart';
import 'package:redux/redux.dart';

final Reducer<bool> resetFeedbackReducer = combineReducers<bool>([
  TypedReducer<bool, ResetFeedbackAction>(_errorOccurredReducer),
  TypedReducer<bool, ResetFeedbackHandledAction>(_errorHandledReducer),
]);

bool _errorOccurredReducer(bool _, ResetFeedbackAction action) {
  return true;
}

bool _errorHandledReducer(bool _, ResetFeedbackHandledAction action) {
  return false;
}