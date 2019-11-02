class GeneralData {
  final String sessKey;
  final String initUsername;

  GeneralData({this.sessKey, this.initUsername});

  factory GeneralData.initial() => GeneralData(
        sessKey: null,
        initUsername: null,
      );

  GeneralData copyWith({String sessKey, String initUsername}) {
    return GeneralData(
      sessKey: sessKey ?? this.sessKey,
      initUsername: initUsername ?? this.initUsername,
    );
  }
}
