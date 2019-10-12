import 'package:lbp/data/LoginData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';

AppState rootReducer(AppState state, action) => AppState(
  fetchReducer<LoginData>(state.login, action),
);