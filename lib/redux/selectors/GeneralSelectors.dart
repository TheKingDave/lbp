import 'package:lbp/data/Language.dart';

import '../AppState.dart';

bool darkModeSelector(AppState state) => state.general.darkMode ?? false;

String sessKeySelector(AppState state) => state.general.sessKey;

String initUsernameSelector(AppState state) => state.general.initUsername;

Language languageSelector(AppState state) => state.general.language;