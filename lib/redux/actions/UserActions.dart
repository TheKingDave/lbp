import 'package:lbp/data/Language.dart';

class SetDarkModeAction {
  bool value;

  SetDarkModeAction(this.value);

  @override
  String toString() {
    return 'SetDarkModeAction{value: $value}';
  }
}

class SetLanguageAction {
  Language value;

  SetLanguageAction(this.value);

  @override
  String toString() {
    return 'SetLanguageAction{value: $value}';
  }
}