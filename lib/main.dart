import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/strings/DefaultStrings.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/RootReducer.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:lbp/redux/middleware/FetchMiddleware.dart';
import 'package:lbp/redux/middleware/LogginMiddleware.dart';
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
      ]);
  await Api.get().init();

  runApp(LBPApp(store: store));
}

class LBPApp extends StatelessWidget {
  final Store store;

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
