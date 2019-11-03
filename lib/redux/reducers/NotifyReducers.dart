import 'package:lbp/data/NotifyModel.dart';
import 'package:lbp/redux/actions/NotifyActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:redux/redux.dart';

final Reducer<NotifyModel> notifyReducer = combineReducers<NotifyModel>([
  TypedReducer<NotifyModel, ErrorOccurredAction>(_errorOccurredReducer),
  TypedReducer<NotifyModel, FetchActionFailure>(_fetchActionFailureReducer),
  TypedReducer<NotifyModel, NotificationHandledAction>(_errorHandledReducer),
  TypedReducer<NotifyModel, NotifyAction>(_notifyActionReducer),
]);

NotifyModel _errorOccurredReducer(NotifyModel _, ErrorOccurredAction action) {
  return NotifyModel(NotifyModel.type_error, action.message);
}

NotifyModel _fetchActionFailureReducer(NotifyModel _, FetchActionFailure action) {
  return NotifyModel(NotifyModel.type_error, action.error.toString());
}

NotifyModel _errorHandledReducer(NotifyModel _, NotificationHandledAction action) {
  return null;
}

NotifyModel _notifyActionReducer(NotifyModel _, NotifyAction action) {
  return action.notify;
}