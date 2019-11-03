import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';
import 'package:lbp/redux/states/FeedbackState.dart';

FeedbackState feedbackReducer(FeedbackState state, action) {
  if(action is FetchAction) {
    return state.copyWith(
      fetch: fetchReducer(state.fetch, action),
    );
  }
  return state;
}