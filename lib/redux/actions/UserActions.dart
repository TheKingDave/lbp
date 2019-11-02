import 'package:lbp/data/Language.dart';

class LogoutAction {}

class SetLanguageAction {
  Language value;

  SetLanguageAction(this.value);

  @override
  String toString() {
    return 'SetLanguageAction{value: $value}';
  }
}