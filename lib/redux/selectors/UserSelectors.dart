import 'package:lbp/data/Language.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/settings/Api.dart';

String userPhotoSelector(AppState state) => state.login.data.photo == null
    ? null
    : Api.getUrl(state.login.data.photo);

String urlSelector(AppState state, [extension = ""]) =>
    Api.getUrl(extension);

String apiUrlSelector(AppState state, [extension = ""]) =>
    Api.getApiUrl(extension);

Language languageSelector(AppState state) =>
    Language(state.login.data?.language);