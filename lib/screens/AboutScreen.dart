import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final PackageInfo packageInfo;

  AboutScreen(this.packageInfo);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(Exception ex)>(
      converter: (store) => (ex) => store.dispatch(ErrorOccurredAction(ex)),
      builder: (context, error) => ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Developer"),
            subtitle: Text("David Langheiter"),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            // Would have said beer but there is no icon for that :(
            title: Text("Buy me a cake"),
            subtitle: Text("paypal.me/DavidLangheiter"),
            onTap: _buildBuyCake(error),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("App version"),
            subtitle: Text("${packageInfo.version}+${packageInfo.buildNumber}"),
          ),
        ],
      ),
    );
  }

  _buildBuyCake(error) => () async {
        const url = "https://paypal.me/DavidLangheiter";
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          error(Exception("Could not open link."));
        }
      };
}
