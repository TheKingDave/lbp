import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/NotifyModel.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/NotifyActions.dart';
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
        final colorMap = {
          NotifyModel.type_error: Theme.of(context).errorColor,
          NotifyModel.type_ok: Color(0xFF00C851),
        };

        if (model.notify != null) {
          model.markNotificationAsHandled();

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(model.notify.message,
                style: TextStyle(color: Colors.white)),
            backgroundColor: colorMap[model.notify.type],
          ));
        }
      },
    );
  }
}

class _NotifierModel {
  final Function markNotificationAsHandled;
  final NotifyModel notify;

  _NotifierModel({this.markNotificationAsHandled, this.notify});

  static _NotifierModel fromStore(Store<AppState> store) {
    return _NotifierModel(
      markNotificationAsHandled: () =>
          store.dispatch(NotificationHandledAction()),
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
