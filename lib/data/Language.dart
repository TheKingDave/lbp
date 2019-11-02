class Language {
  static final List<Language> languages = [Language.en, Language.de];

  static final en = Language("en");
  static final de = Language("de");

  static const Map<String, String> nameMap = {
    "en": "English",
    "de": "Deutsch",
  };

  final String short;
  final String name;

  Language._internal(this.short, this.name);

  factory Language(String short) {
    if (!nameMap.containsKey(short)) {
      throw ArgumentError.value(
          short, "short", "Must be one of: ${nameMap.keys}");
    }
    return Language._internal(short, nameMap[short]);
  }

  @override
  String toString() {
    return 'Language{short: $short, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language &&
          runtimeType == other.runtimeType &&
          short == other.short &&
          name == other.name;

  @override
  int get hashCode => short.hashCode ^ name.hashCode;
}
