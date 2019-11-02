class GeneralData {
  final String sessKey;
  final String initUsername;
  final bool darkMode;

  GeneralData({this.sessKey, this.initUsername, this.darkMode});

  factory GeneralData.initial() => GeneralData(
        sessKey: null,
        initUsername: null,
        darkMode: false,
      );

  GeneralData copyWith({String sessKey, String initUsername, bool darkMode}) {
    return GeneralData(
      sessKey: sessKey ?? this.sessKey,
      initUsername: initUsername ?? this.initUsername,
      darkMode: darkMode ?? this.darkMode,
    );
  }
}
