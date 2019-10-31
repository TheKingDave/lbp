import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/UserActions.dart';

class TeacherOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return StoreConnector<AppState, Function()>(
        converter: (store) => () => store.dispatch(LogoutAction()),
        builder: (_, logout) => Scaffold(
            appBar: AppBar(
              leading:
                  IconButton(icon: Icon(Icons.exit_to_app), onPressed: logout),
              title: Text(Strings.getCapitalize("a_not_implemented")),
              actions: <Widget>[
                Image(image: AssetImage("assets/img/icon.jpg"))
              ],
            ),
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info_outline, color: t.errorColor, size: 150),
                    Text(Strings.getCapitalize("a_not_implemented"),
                        style: t.textTheme.headline),
                    Text(Strings.getCapitalize("a_no_teacher_page")),
                    RaisedButton.icon(
                      onPressed: logout,
                      icon: Icon(Icons.exit_to_app),
                      label: Text(Strings.getCapitalize("sign_out")),
                    ),
                  ],
                ),
              ),
            )));
  }
}
