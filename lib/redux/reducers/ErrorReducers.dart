import 'package:lbp/data/NotifyModel.dart';
import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:redux/redux.dart';

final Reducer<NotifyModel> notifyReducer = combineReducers<NotifyModel>([
  TypedReducer<NotifyModel, ErrorOccurredAction>(_errorOccurredReducer),
  TypedReducer<NotifyModel, FetchActionFailure>(_fetchActionFailureReducer),
  TypedReducer<NotifyModel, ErrorHandledAction>(_errorHandledReducer),
]);

NotifyModel _errorOccurredReducer(NotifyModel _, ErrorOccurredAction action) {
  return NotifyModel(NotifyModel.type_error, action.message);
}

NotifyModel _fetchActionFailureReducer(NotifyModel _, FetchActionFailure action) {
  return NotifyModel(NotifyModel.type_error, action.error.toString());
}

NotifyModel _errorHandledReducer(NotifyModel _, ErrorHandledAction action) {
  return null;
}
