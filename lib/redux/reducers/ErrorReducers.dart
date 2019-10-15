import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:redux/redux.dart';

final Reducer<Exception> errorReducer = combineReducers<Exception>([
  TypedReducer<Exception, ErrorOccurredAction>(_errorOccurredReducer),
  TypedReducer<Exception, FetchActionFailure>(_fetchActionFailureReducer),
  TypedReducer<Exception, ErrorHandledAction>(_errorHandledReducer),
]);

Exception _errorOccurredReducer(Exception _, ErrorOccurredAction action) {
  return action.exception;
}

Exception _fetchActionFailureReducer(Exception _, FetchActionFailure action) {
  return action.error;
}

Exception _errorHandledReducer(Exception _, ErrorHandledAction action) {
  return null;
}
