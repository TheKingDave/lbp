import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:redux/redux.dart';

class ErrorNotifier extends StatelessWidget {
  final Widget child;

  ErrorNotifier({@required this.child});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ErrorNotifierModel>(
      distinct: true,
      converter: (store) => _ErrorNotifierModel.fromStore(store),
      builder: (context, model) => child,
      onWillChange: (model) {
        if(model.error != null) {
          model.markErrorAsHandled();

          Scaffold.of(context)
              .showSnackBar(SnackBar(
            content: Text(model.error.toString()),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
      },
    );
  }
}

class _ErrorNotifierModel {
  final Function markErrorAsHandled;
  final Exception error;

  _ErrorNotifierModel({this.markErrorAsHandled, this.error});

  static _ErrorNotifierModel fromStore(Store<AppState> store) {
    return _ErrorNotifierModel(
      markErrorAsHandled: () => store.dispatch(ErrorHandledAction()),
      error: store.state.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ErrorNotifierModel &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}
