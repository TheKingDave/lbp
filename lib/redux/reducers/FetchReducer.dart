import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/states/FetchState.dart';

FetchState<T> fetchReducer<T>(FetchState<T> state, action) {
  if (action is FetchActionStart<T>) {
    return FetchState<T>(null, true, null);
  } else if (action is FetchActionSuccess<T>) {
    return FetchState<T>(action.data, false, null);
  } else if (action is FetchActionFailure<T>) {
    return FetchState<T>(null, false, action.error);
  }

  return state;
}
