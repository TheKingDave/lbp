import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/RouteActions.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';
import 'package:lbp/redux/selectors/UserSelectors.dart';
import 'package:lbp/ui/UserAvatar.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _State>(
        distinct: true,
        converter: (store) => _State(
              loginData: store.state.login.data,
              photoUrl: userPhotoSelector(store.state),
              logout: () => store.dispatch(LogoutAction()),
              push: (route) => store.dispatch(NavigatePushAction(route)),
              weekdays: List.from(
                  daysListSelector(store.state).map((d) => d.getWeekDay())),
            ),
        builder: (context, state) {
          LoginData loginData = state.loginData;

          String routeName = ModalRoute.of(context).settings.name;
          dynamic routeArgs = ModalRoute.of(context).settings.arguments;
          Function(String path) isCurrentPath = (path) => path == routeName;

          final children = <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text(loginData.fullName),
                accountEmail:
                    loginData.email == null ? null : Text(loginData.email),
                currentAccountPicture: UserAvatar(state.photoUrl)),
            ListTile(
              title: Text("Overview"),
              onTap: () => state.push(RouteNames.overview),
              selected: isCurrentPath(RouteNames.overview),
            ),
            Divider(),
          ];

          for (int wd in state.weekdays) {
            children.add(ListTile(
              title: Text(Strings.getWeekdayString(wd)),
              onTap: () => Navigator.pushNamed(context, RouteNames.day,
                  arguments: DayRouteData(wd)),
              selected: isCurrentPath(RouteNames.day) && routeArgs.day == wd,
            ));
          }

          children.addAll([
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
              onTap: () => state.push(RouteNames.settings),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () => state.push(RouteNames.about),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: state.logout,
            )
          ]);

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
  final Function(String route) push;
  final List<int> weekdays;

  _State({this.loginData, this.photoUrl, this.logout, this.push, this.weekdays});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _State &&
          runtimeType == other.runtimeType &&
          loginData == other.loginData &&
          photoUrl == other.photoUrl &&
          weekdays == other.weekdays;

  @override
  int get hashCode =>
      loginData.hashCode ^ photoUrl.hashCode ^ weekdays.hashCode;
}
