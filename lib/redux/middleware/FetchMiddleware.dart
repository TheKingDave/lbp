import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

void fetchMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  if (action is FetchDataAction) {
    next(action.getStartAction());
    final ac = await action.fetchData();
    next(ac);
    if(ac is FetchActionFailure) {
      FetchActionFailure faf = ac as FetchActionFailure;
      next(ErrorOccurredAction(faf.error));
    }
  } else {
    next(action);
  }
}
