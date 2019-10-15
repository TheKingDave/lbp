import 'package:lbp/api/etc/Language.dart';
import 'package:lbp/redux/AppState.dart';

String userPhotoSelector(AppState state) => state.login.data.photo == null
    ? null
    : urlSelector(state, state.login.data.photo);

String urlSelector(AppState state, [extension = ""]) =>
    "${state.config.webUrl}$extension";

String apiUrlSelector(AppState state, [extension = ""]) =>
    "${state.config.webUrl}/${state.config.apiUrl}$extension";

Language languageSelector(AppState state) =>
    Language(state.login.data.language);

bool darkModeSelector(AppState state) => state.login.data.darkMode;
