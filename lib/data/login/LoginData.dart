import 'package:lbp/api/ApiResponse.dart';

class LoginData extends ApiResponses {
  String $class;
  String fullName;
  String email;
  bool darkMode;
  String language;
  String sessionKey;
  bool isTeacher;
  String photo;

  LoginData(
      {this.$class,
      this.fullName,
      this.email,
      this.darkMode,
      this.language,
      this.sessionKey,
      this.isTeacher,
      this.photo}) {
    if (email == "NULL") email = null;
  }

  factory LoginData.copy(LoginData other,
          {String $class,
          String fullName,
          String  email,
          bool darkMode,
          String language,
          String sessionKey,
          bool isTeacher,
          String photo}) =>
      LoginData(
        $class: $class ?? other.$class,
        fullName: fullName ?? other.fullName,
        email: email ?? other.email,
        darkMode: darkMode ?? other.darkMode,
        language: language ?? other.language,
        sessionKey: sessionKey ?? other.sessionKey,
        isTeacher: isTeacher ?? other.isTeacher,
        photo: photo ?? other.photo,
      );

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      $class: json['class'],
      fullName: json['FullName'],
      email: json['email'],
      darkMode: json['theme'] == "dark",
      language: json['language'],
      sessionKey: json['session_key'],
      isTeacher: json['isTeacher'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.$class;
    data['FullName'] = this.fullName;
    data['email'] = this.email;
    data['theme'] = this.darkMode ? 'dark' : 'light';
    data['language'] = this.language;
    data['session_key'] = this.sessionKey;
    data['isTeacher'] = this.isTeacher;
    data['photo'] = this.photo;
    return data;
  }

  @override
  String toString() {
    return 'LoginResponse{"class": ${$class}, fullName: $fullName, email: $email, darkMode: $darkMode, language: $language, sessionKey: $sessionKey, isTeacher: $isTeacher, photo: $photo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LoginData &&
              runtimeType == other.runtimeType &&
              $class == other.$class &&
              fullName == other.fullName &&
              email == other.email &&
              darkMode == other.darkMode &&
              language == other.language &&
              sessionKey == other.sessionKey &&
              isTeacher == other.isTeacher &&
              photo == other.photo;

  @override
  int get hashCode =>
      $class.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      darkMode.hashCode ^
      language.hashCode ^
      sessionKey.hashCode ^
      isTeacher.hashCode ^
      photo.hashCode;

}
