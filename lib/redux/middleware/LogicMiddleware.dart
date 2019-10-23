import 'package:redux/redux.dart';

abstract class Logic<State> {
  /// Defines if the other logic should be called or the action passed on
  bool exclusive;

  Logic({this.exclusive = false});

  /// Return `true` if logic was executed (Used for exclusive)
  bool call(Store<State> store, NextDispatcher next, dynamic action);
}

class TypedLogic<State, Action> extends Logic<State> {
  final void Function(Store<State> store, NextDispatcher next, Action action)
      exec;

  TypedLogic(this.exec, {exclusive}) : super(exclusive: exclusive);

  @override
  bool call(Store<State> store, NextDispatcher next, action) {
    if (action is Action) {
      exec(store, next, action);
      return true;
    }
    return false;
  }
}

class LogicMiddleware<State> extends MiddlewareClass<State> {
  final List<Logic> logic;

  LogicMiddleware({this.logic});

  @override
  void call(Store<State> store, action, next) {
    for (Logic l in logic) {
      if (l.call(store, next, action) && l.exclusive) {
        return;
      }
    }
    next(action);
  }
}
