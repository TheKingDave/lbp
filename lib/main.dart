import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/lessons/DaysRequest.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/RootReducer.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:lbp/redux/middleware/FetchMiddleware.dart';
import 'package:lbp/redux/middleware/LogginMiddleware.dart';
import 'package:lbp/redux/middleware/RouteMiddleware.dart';
import 'package:lbp/screens/LoginScreen.dart';
import 'package:lbp/screens/OverviewScreen.dart';
import 'package:lbp/screens/SettingsScreen.dart';
import 'package:lbp/settings/Themes.dart';
import 'package:lbp/ui/DefaultScaffold.dart';
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
        RouteMiddleware(),
      ]);

  store.dispatch(FetchDataAction<Days, DaysRequest>(DaysRequest(
      sess_key:
          "9FBE1F9353B772E4FA4F75852E6321BCBBB6C28A03756447C3716BEC477D82918FCB70ABDFF742386F8B9BB5FFC24F32CE17F74DCC5CAFD6695986BDE37ABF6A")));

  runApp(LBPApp(store: store));
}

GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

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
        theme: Themes.lightTheme,
      ),
    );
  }
}
