import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/ApiData.dart';
import 'package:lbp/api/login/LoginRespsone.dart';
import 'package:lbp/helpers.dart';
import 'package:lbp/ui/UserAvatar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Api api = Api.get();
    LoginResponse data = api.getData(ApiData.loginData);
    cPrint(data.photo);

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
        ListTile(
          title: Text("Item 2"),
          onTap: () => cPrint("NAV: Item 2"),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              title: Text("Settings"),
              onTap: () => cPrint("NAV: Settings"),
            ))
      ],
    ));
  }
}
