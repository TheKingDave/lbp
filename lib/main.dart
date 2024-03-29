import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/RouteNames.dart';
import 'package:lbp/data/general/GeneralData.dart';
import 'package:lbp/logic/Logics.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/RootReducer.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:lbp/redux/middleware/FetchMiddleware.dart';
import 'package:lbp/redux/middleware/LogginMiddleware.dart';
import 'package:lbp/redux/middleware/LogicMiddleware.dart';
import 'package:lbp/redux/middleware/RouteMiddleware.dart';
import 'package:lbp/redux/selectors/GeneralSelectors.dart';
import 'package:lbp/screens/AboutScreen.dart';
import 'package:lbp/screens/FeedbackScreen.dart';
import 'package:lbp/screens/LoginScreen.dart';
import 'package:lbp/screens/NotFoundScreen.dart';
import 'package:lbp/screens/Overview/OverviewScreen.dart';
import 'package:lbp/screens/SettingsScreen.dart';
import 'package:lbp/screens/TeacherOverview.dart';
import 'package:lbp/settings/Themes.dart';
import 'package:lbp/screens/Day/DayContainer.dart';
import 'package:lbp/ui/DefaultScaffold.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

import 'data/strings/Strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: load data from disk/preferences
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // TODO: init redux state with data from disk
  // TODO: remove loggin middleware
  List<Middleware<AppState>> middleware = [
    ApiMiddleware<AppState>(),
    fetchMiddleware,
    LogicMiddleware(logic: logics),
    RouteMiddleware(),
  ];

  assert(() {
    middleware = [
      LoggingMiddleware("1"),
      ApiMiddleware<AppState>(),
      LoggingMiddleware("2"),
      fetchMiddleware,
      LoggingMiddleware("3"),
      LogicMiddleware(logic: logics),
      LoggingMiddleware("4"),
      RouteMiddleware(),
    ];
    return true;
  }());

  GeneralData initGD = await GeneralData.loadInitial();

  final store = new Store<AppState>(rootReducer,
      initialState: AppState.initial(initGD), middleware: middleware);

  if (sessKeySelector(store.state) != null) {
    store.dispatch(ApiLoginActionSessKey());
  }

  await Strings.loadFromAssets(languageSelector((store.state)));
  store.dispatch(ApiSetLanguageAction(languageSelector(store.state)));

  runApp(LBPApp(
    store: store,
    packageInfo: packageInfo,
  ));
}

GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class LBPApp extends StatelessWidget {
  final Store store;
  final PackageInfo packageInfo;

  LBPApp({@required this.store, this.packageInfo});

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(
            settings: settings,
            maintainState: false,
            builder: (_) => LoginScreen());
      case RouteNames.studentOverview:
        return MaterialPageRoute(
            settings: settings,
            maintainState: false,
            builder: (_) => DefaultScaffold(
                name: Strings.getCapitalize("overview"),
                child: OverviewScreen()));
      case RouteNames.studentDay:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => DayContainer(settings.arguments),
        );
      case RouteNames.feedback:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => DefaultScaffold(
              name: Strings.getCapitalize("feedback"), child: FeedbackScreen()),
        );
      case RouteNames.settings:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => DefaultScaffold(
              name: Strings.getCapitalize("settings"), child: SettingsScreen()),
        );
      case RouteNames.about:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => DefaultScaffold(
              name: Strings.getCapitalize("a_about"),
              child: AboutScreen(packageInfo)),
        );
      case RouteNames.openSourceLicenses:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => LicensePage(),
        );
      case RouteNames.teacherOverview:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => TeacherOverview(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          builder: (_) => NotFoundScreen(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _MainModel>(
        distinct: true,
        converter: (store) => _MainModel(
            darkMode: darkModeSelector(store.state),
            reload: store.state.forceReloadCounter),
        builder: (_, model) => MaterialApp(
          title: 'Lernbüro Planer',
          initialRoute: '/login',
          navigatorKey: navigatorKey,
          onGenerateRoute: _generateRoute,
          theme: model.darkMode ? Themes.darkTheme : Themes.lightTheme,
        ),
      ),
    );
  }
}

class _MainModel {
  final bool darkMode;
  final int reload;

  _MainModel({this.darkMode, this.reload});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _MainModel &&
          runtimeType == other.runtimeType &&
          darkMode == other.darkMode &&
          reload == other.reload;

  @override
  int get hashCode => darkMode.hashCode ^ reload.hashCode;
}
