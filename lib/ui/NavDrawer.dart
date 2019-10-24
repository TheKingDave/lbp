import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/selectors/UserSelectors.dart';
import 'package:lbp/ui/UserAvatar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _State>(
        converter: (store) => _State(
            loginData: store.state.login.data,
            photoUrl: userPhotoSelector(store.state)),
        builder: (context, state) {
          String route = ModalRoute.of(context).settings.name;

          Function(String path) isCurrentPath = (path) => path == route;

          LoginData loginData = state.loginData;
          return Drawer(
              child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text(loginData.fullName),
                  accountEmail:
                      loginData.email == null ? null : Text(loginData.email),
                  currentAccountPicture: UserAvatar(state.photoUrl)),
              ListTile(
                title: Text("Overview"),
                onTap: () => Navigator.pushNamed(context, RouteNames.overview),
                selected: isCurrentPath(RouteNames.overview),
              ),
              Divider(),
              ListTile(
                title: Text("Tuesday"),
                onTap: () => Navigator.pushNamed(context, RouteNames.day,
                    arguments: "tuesday"),
                selected: isCurrentPath(RouteNames.day),
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
                selected: isCurrentPath(RouteNames.settings),
                onTap: () => Navigator.pushNamed(context, RouteNames.settings),
              ),
            ],
          ));
        });
  }
}

class _State {
  LoginData loginData;
  String photoUrl;

  _State({this.loginData, this.photoUrl});
}
