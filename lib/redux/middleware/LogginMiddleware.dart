import 'package:lbp/etc/helpers.dart';
import 'package:redux/redux.dart';

class LoggingMiddleware<State> extends MiddlewareClass<State> {
  final String prefix;

  LoggingMiddleware(this.prefix);

  @override
  void call(Store<State> store, action, next) {
    cPrint('log $prefix $action');

    next(action);
  }

}