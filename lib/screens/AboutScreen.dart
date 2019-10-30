import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatelessWidget {
  final PackageInfo packageInfo;

  AboutScreen(this.packageInfo);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.info),
          title: Text("App version"),
          subtitle: Text("${packageInfo.version}+${packageInfo.buildNumber}"),
        ),
        ListTile(
          leading: Icon(Icons.person_outline),
          title: Text("Developer"),
          subtitle: Text("David Langheiter"),
        ),
        ListTile(
          leading: Icon(Icons.cake),
          title: Text("Buy me a cake"),
          subtitle: Text("paypal.me/DavidLangheiter"),
        ),
      ],
    );
  }

}