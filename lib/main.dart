import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/strings/DefaultStrings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/RootReducer.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:lbp/redux/middleware/FetchMiddleware.dart';
import 'package:lbp/redux/middleware/LogginMiddleware.dart';
import 'package:lbp/redux/middleware/RouteMiddleware.dart';
import 'package:lbp/screens/OverviewScreen.dart';
import 'package:lbp/screens/SettingsScreen.dart';
import 'package:lbp/ui/DefaultScaffold.dart';
import 'package:lbp/screens/LoginScreen.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: load data from disk/preferences
  DefaultStrings.setDefaultString();

  // TODO: init redux state with data from disk
  // TODO: remove loggin middleware
  final store = new Store<AppState>(rootReducer,
      initialState: AppState.initial(), middleware: [
        LoggingMiddleware("1"),
        ApiMiddleware<AppState>(),
        LoggingMiddleware("2"),
        fetchMiddleware,
        LoggingMiddleware("3"),
        RouteMiddleware(),
      ]);
  await Api.get().init();

  runApp(LBPApp(store: store));
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class LBPApp extends StatelessWidget {
  final Store store;

  LBPApp({@required this.store});

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
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF2A47E4),
        ),
      ),
    );
  }
}
