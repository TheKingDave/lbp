import 'package:lbp/data/Language.dart';
import 'package:lbp/etc/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralData {
  final String sessKey;
  final String initUsername;
  final bool darkMode;
  final Language language;

  GeneralData({this.sessKey, this.initUsername, this.darkMode, this.language});

  factory GeneralData.initial() {
    return GeneralData(
      sessKey: null,
      initUsername: null,
      darkMode: false,
      language: Language.en,
    );
  }

  static Future<GeneralData> loadInitial() async {
    final sp = await SharedPreferences.getInstance();
    return GeneralData(
      sessKey: sp.getString(Constants.sp_sess_key),
      initUsername: sp.getString(Constants.sp_username),
      darkMode: sp.getBool(Constants.sp_dark_mode) ?? false,
      language: Language(sp.getString(Constants.sp_language)),
    );
  }

  GeneralData copyWith(
      {String sessKey, String initUsername, bool darkMode, Language language}) {
    return GeneralData(
      sessKey: sessKey ?? this.sessKey,
      initUsername: initUsername ?? this.initUsername,
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
    );
  }
}
