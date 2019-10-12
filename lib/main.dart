import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/login/LoginRequest.dart';
import 'package:lbp/api/strings/DefaultStrings.dart';
import 'package:lbp/data/LoginData.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/RootReducer.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/middleware/FetchMiddleware.dart';
import 'package:lbp/screens/OverviewScreen.dart';
import 'package:lbp/screens/SettingsScreen.dart';
import 'package:lbp/ui/DefaultScaffold.dart';
import 'package:lbp/screens/LoginScreen.dart';
import 'package:redux/redux.dart';

loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  cPrint('$action');

  next(action);
  cPrint('${store.state.login}');
}

void main() async {
  // TODO: load data from disk/preferences
  DefaultStrings.setDefaultString();

  // TODO: init redux state with data from disk
  // TODO: remove loggin middleware
  final store =
      new Store(rootReducer, initialState: AppState.initial, middleware: [
    loggingMiddleware,
    fetchMiddleware,
    loggingMiddleware,
  ]);
  await Api.get().init();

  runApp(LBPApp(store: store));
}

class LBPApp extends StatelessWidget {
  Store store;

  LBPApp({@required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Lernbüro Planer',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/overview': (context) =>
              DefaultScaffold(name: "Overview", child: OverviewScreen()),
          '/settings': (context) =>
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
