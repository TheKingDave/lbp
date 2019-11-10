import 'package:lbp/etc/Constants.dart';
import 'package:lbp/redux/AppState.dart';

String userPhotoSelector(AppState state) => state.login.data.photo == null
    ? null
    : "${Constants.api_web_url}${state.login.data.photo}";

String emailSelector(AppState state) =>
    state.login.data?.email ?? state.login.data?.fullName ?? 'UNKNOWN';
