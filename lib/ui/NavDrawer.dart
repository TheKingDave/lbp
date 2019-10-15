import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/ApiData.dart';
import 'package:lbp/data/LoginData.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/ui/UserAvatar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _state>(
      converter: (store) => _state(loginData: store.state.login.data),
        builder: (context, state) {
        LoginData loginData = state.loginData;
          return Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                      accountEmail: Text(loginData.email),
                      accountName: Text(loginData.fullName),
                      currentAccountPicture: UserAvatar(loginData.photo, loginData.email)),
                  ListTile(
                    title: Text("Overview"),
                    onTap: () => cPrint("NAV: Overview"),
                  ),
                  Divider(),

                  ListTile(
                    title: Text("Tuesday"),
                    onTap: () => cPrint("NAV: Tuesday"),
                  ),
                  ListTile(
                    title: Text("Wendesday"),
                    onTap: () => cPrint("NAV: Wendesday"),
                  ),
                  ListTile(
                    title: Text("Thursday"),
                    onTap: () => cPrint("NAV: Thursday"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text("Send feedback"),
                    onTap: () => cPrint("NAV: Issue"),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () => Navigator.pushNamed(context, "/settings"),
                  ),
                ],
              ));
        }
    );
  }
}

class _state {
  LoginData loginData;

  _state({this.loginData});
}