import '../AppState.dart';

bool darkModeSelector(AppState state) => state.general.darkMode ?? false;

String sessKeySelector(AppState state) => state.general.sessKey;

String initUsernameSelector(AppState state) => state.general.initUsername;