import 'package:redux/redux.dart';

abstract class Logic<State> {
  void call(Store<State> store, NextDispatcher next, dynamic action);
}

class TypedLogic<State, Action> extends Logic<State> {
  final void Function(Store<State> store, NextDispatcher next, Action action)
      exec;

  TypedLogic(this.exec);

  @override
  void call(Store<State> store, NextDispatcher next, action) {
    if (action is Action) exec(store, next, action);
  }
}

class LogicMiddleware<State> extends MiddlewareClass<State> {
  final List<Logic> logic;

  LogicMiddleware({this.logic});

  @override
  void call(Store<State> store, action, next) {
    next(action);
    for (Logic l in logic) {
      l.call(store, next, action);
    }
  }
}
