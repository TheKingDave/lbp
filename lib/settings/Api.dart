class Api {

  static String baseUrl = "https://lb-planer.tgm.ac.at";
  static String apiUrl = "$baseUrl/api/v1";

  static String forceLeadingSlash(String str) {
    return str.startsWith("/") ? str : "/$str";
  }

  static String getUrl([String extension = ""]) {
    return "$baseUrl${forceLeadingSlash(extension)}";
  }

  static String getApiUrl([String extension = ""]) {
    return "$apiUrl${forceLeadingSlash(extension)}";
  }

}