import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

void fetchMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is FetchDataAction) {
    action.fetchData(store, next);
  } else {
    next(action);
  }
}
