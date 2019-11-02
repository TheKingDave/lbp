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
