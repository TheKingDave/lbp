import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/logic/Logics.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/RootReducer.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:lbp/redux/middleware/FetchMiddleware.dart';
import 'package:lbp/redux/middleware/LogginMiddleware.dart';
import 'package:lbp/redux/middleware/LogicMiddleware.dart';
import 'package:lbp/redux/middleware/RouteMiddleware.dart';
import 'package:lbp/screens/AboutScreen.dart';
import 'package:lbp/screens/LoginScreen.dart';
import 'package:lbp/screens/OpenSourceLicenseScreen.dart';
import 'package:lbp/screens/OverviewScreen.dart';
import 'package:lbp/screens/SettingsScreen.dart';
import 'package:lbp/settings/Themes.dart';
import 'package:lbp/screens/Day/DayContainer.dart';
import 'package:lbp/ui/DefaultScaffold.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

import 'data/strings/DefaultStrings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: load data from disk/preferences
  DefaultStrings.setDefaultString();

  // TODO: init redux state with data from disk
  // TODO: remove loggin middleware
  final store = new Store<AppState>(rootReducer,
      initialState: AppState.initial(),
      middleware: [
        LoggingMiddleware("1"),
        ApiMiddleware<AppState>(),
        LoggingMiddleware("2"),
        fetchMiddleware,
        LoggingMiddleware("3"),
        LogicMiddleware(logic: logics),
        LoggingMiddleware("4"),
        RouteMiddleware(),
      ]);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  runApp(LBPApp(store: store, packageInfo: packageInfo));
}

GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class LBPApp extends StatelessWidget {
  final Store store;
  final PackageInfo packageInfo;

  LBPApp({@required this.store, this.packageInfo});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Lernbüro Planer',
        initialRoute: '/login',
        navigatorKey: navigatorKey,
        routes: {
          RouteNames.login: (context) => LoginScreen(),
          RouteNames.overview: (context) =>
              DefaultScaffold(name: "Overview", child: OverviewScreen()),
          RouteNames.settings: (context) =>
              DefaultScaffold(name: "Settings", child: SettingsScreen()),
          RouteNames.day: (context) => DayContainer(),
          RouteNames.about: (context) =>
              DefaultScaffold(name: "About", child: AboutScreen(packageInfo)),
          RouteNames.openSourceLicenses: (context) => DefaultScaffold(
                name: "Open source licenses",
                drawer: false,
                child: OpenSourceLicenseScreen(),
              )
        },
        theme: Themes.lightTheme,
      ),
    );
  }
}
