import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/ApiData.dart';
import 'package:lbp/data/LoginData.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/ui/UserAvatar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Api api = Api.get();
    LoginData data = api.getData(ApiData.loginData);

    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
            accountEmail: Text(data.email),
            accountName: Text(data.fullName),
            currentAccountPicture: UserAvatar(data.photo, data.email)),
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
}
