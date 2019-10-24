import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';
import 'package:lbp/redux/selectors/UserSelectors.dart';
import 'package:lbp/ui/UserAvatar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _State>(
        converter: (store) => _State(
              loginData: store.state.login.data,
              photoUrl: userPhotoSelector(store.state),
              logout: () => store.dispatch(LogoutAction()),
              weekdays: List.from(
                  daysListSelector(store.state).map((d) => d.getWeekDay())),
            ),
        builder: (context, state) {
          String route = ModalRoute.of(context).settings.name;

          Function(String path) isCurrentPath = (path) => path == route;

          LoginData loginData = state.loginData;



          final children = <Widget>[
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
          ];

          for(String wd in state.weekdays) {
            children.add(ListTile(
              title: Text(wd),
              onTap: () => Navigator.pushNamed(context, RouteNames.day,
                  arguments: wd),
              selected: isCurrentPath(RouteNames.day),
            ));
          }

          children.addAll([Divider(),
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
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: state.logout,
            )]);

          return Drawer(
              child: ListView(
            children: children,
          ));
        });
  }
}

class _State {
  final LoginData loginData;
  final String photoUrl;
  final Function() logout;
  final List<String> weekdays;

  _State({this.loginData, this.photoUrl, this.logout, this.weekdays});
}
