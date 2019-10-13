import 'package:redux/redux.dart';

abstract class ApiAction<State> {}

abstract class ApiActionWithApiCall<State> extends ApiAction<State> {
  void call(Store<State> store, NextDispatcher next);
}

class TypedApiCall<State, Action extends ApiAction> extends ApiCall<State> {
  final void Function(Store<State> store, Action action) reducer;

  TypedApiCall(this.reducer);

  void call(Store<State> store, dynamic action) {
    if (action is Action) reducer(store, action);
  }
}

abstract class ApiCall<State> {
  void call(Store<State> store, dynamic action);
}

class ApiMiddleware<State> extends MiddlewareClass<State> {
  final Iterable<ApiCall<State>> apiCalls;

  ApiMiddleware([this.apiCalls = const []]);

  @override
  void call(Store<State> store, action, next) {
    if (action is ApiAction<State>) {
      if(action is ApiActionWithApiCall<State>) {
        action.call(store, next);
      } else {
        apiCalls.forEach((c) => c.call(store, next));
      }
    } else {
      next(action);
    }
  }
}
