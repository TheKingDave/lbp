import 'package:lbp/etc/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralData {
  final String sessKey;
  final String initUsername;
  final bool darkMode;

  GeneralData({this.sessKey, this.initUsername, this.darkMode});

  static initial() async {
    final sp = await SharedPreferences.getInstance();
    return GeneralData(
      sessKey: sp.getString(Constants.sp_sess_key),
      initUsername: sp.getString(Constants.sp_username),
      darkMode: sp.getBool(Constants.sp_dark_mode) ?? false,
    );
  }

  GeneralData copyWith({String sessKey, String initUsername, bool darkMode}) {
    return GeneralData(
      sessKey: sessKey ?? this.sessKey,
      initUsername: initUsername ?? this.initUsername,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
