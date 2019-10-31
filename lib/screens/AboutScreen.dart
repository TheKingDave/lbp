import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final PackageInfo packageInfo;

  AboutScreen(this.packageInfo);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _AboutScreenState>(
      distinct: true,
      converter: (store) => _AboutScreenState(
        error: (ex) => store.dispatch(ErrorOccurredAction(ex)),
        osl: () =>
            store.dispatch(NavigatePushAction(RouteNames.openSourceLicenses)),
      ),
      builder: (context, state) => ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(Strings.getCapitalize("a_developer")),
            subtitle: Text(Strings.getCapitalize("a_developer_name")),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            // Would have said beer but there is no icon for that :(
            title: Text(Strings.getCapitalize("a_buy_cake")),
            subtitle: Text(Strings.getString("a_buy_cake_link")),
            onTap: _buildBuyCake(state.error),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(Strings.getCapitalize("a_app_version")),
            subtitle: Text("${packageInfo.version}+${packageInfo.buildNumber}"),
          ),
          ListTile(
            leading: Icon(Icons.public),
            title: Text(Strings.getCapitalize("a_osl")),
            onTap: state.osl,
          ),
        ],
      ),
    );
  }

  _buildBuyCake(error) => () async {
        final url = Strings.getString("a_buy_cake_redirect_link");
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          error(Exception(Strings.getCapitalize("A_COULD_NOT_OPEN_LINK")));
        }
      };
}

class _AboutScreenState {
  final Function(Exception ex) error;
  final Function() osl;

  _AboutScreenState({this.error, this.osl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _AboutScreenState &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          osl == other.osl;

  @override
  int get hashCode => error.hashCode ^ osl.hashCode;
}
