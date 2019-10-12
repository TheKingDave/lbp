import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

void fetchMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  if (action is FetchDataAction) {
    next(action.getStartAction());
    next(await action.fetchData());
  } else {
    next(action);
  }
}
