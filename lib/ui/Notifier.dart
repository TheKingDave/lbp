import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/NotifyModel.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:redux/redux.dart';

class Notifier extends StatelessWidget {
  final Widget child;

  Notifier({@required this.child});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _NotifierModel>(
      distinct: true,
      converter: (store) => _NotifierModel.fromStore(store),
      builder: (context, model) => child,
      onWillChange: (model) {
        if(model.notify != null) {
          model.markErrorAsHandled();

          Scaffold.of(context)
              .showSnackBar(SnackBar(
            content: Text(model.notify.message),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
      },
    );
  }
}

class _NotifierModel {
  final Function markErrorAsHandled;
  final NotifyModel notify;

  _NotifierModel({this.markErrorAsHandled, this.notify});

  static _NotifierModel fromStore(Store<AppState> store) {
    return _NotifierModel(
      markErrorAsHandled: () => store.dispatch(ErrorHandledAction()),
      notify: store.state.notify,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _NotifierModel &&
              runtimeType == other.runtimeType &&
              notify == other.notify;

  @override
  int get hashCode => notify.hashCode;
}
