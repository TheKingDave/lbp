import 'package:lbp/data/Language.dart';
import 'package:lbp/data/general/SetLanguageRequest.dart';
import 'package:lbp/data/general/SetLanguageResponse.dart';
import 'package:lbp/redux/actions/FetchAction.dart';
import 'package:lbp/redux/middleware/ApiMiddleware.dart';
import 'package:redux/src/store.dart';

abstract class GeneralAction {}

class SetSessKeyAction extends GeneralAction {
  final String sessKey;

  SetSessKeyAction(this.sessKey);
}

class SetInitUsernameAction extends GeneralAction {
  final String initUsername;

  SetInitUsernameAction(this.initUsername);
}

class SetDarkModeAction extends GeneralAction {
  final bool darkMode;

  SetDarkModeAction(this.darkMode);
}

class SetLanguageAction extends GeneralAction {
  final Language language;

  SetLanguageAction(this.language);
}