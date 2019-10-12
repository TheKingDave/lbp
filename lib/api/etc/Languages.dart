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

  Language(this.short) : name = nameMap[short];
}
