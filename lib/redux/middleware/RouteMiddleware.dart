import 'package:lbp/main.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:redux/redux.dart';

class RouteMiddleware<T> extends MiddlewareClass<T> {

  @override
  void call(Store<T> store, action, next) {
    if (action is RouteAction) {
      if (action is NavigateReplaceAction) {
        navigatorKey.currentState.pushReplacementNamed(action.routeName);
      } else if (action is NavigatePushAction) {
        navigatorKey.currentState.pushNamed(action.routeName);
      }
    } else if(action is NavigatePopAction) {
      navigatorKey.currentState.pop();
    } else {
      next(action);
    }
  }
}
