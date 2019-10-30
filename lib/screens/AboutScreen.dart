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
          title: Text("Version name"),
          subtitle: Text(packageInfo.version),
        ),
        ListTile(
          title: Text("Build number"),
          subtitle: Text(packageInfo.buildNumber),
        ),
      ],
    );
  }

}