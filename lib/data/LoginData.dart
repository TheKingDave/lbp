import 'package:lbp/api/ApiResponse.dart';

class LoginData extends ApiResponses {
  String $class;
  String fullName;
  String email;
  String theme;
  String language;
  String sessionKey;
  bool isTeacher;
  String photo;

  LoginData(
      {this.$class,
      this.fullName,
      this.email,
      this.theme,
      this.language,
      this.sessionKey,
      this.isTeacher,
      this.photo});

  LoginData.fromJson(Map<String, dynamic> json) {
    $class = json['class'];
    fullName = json['FullName'];
    email = json['email'];
    theme = json['theme'];
    language = json['language'];
    sessionKey = json['session_key'];
    isTeacher = json['isTeacher'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.$class;
    data['FullName'] = this.fullName;
    data['email'] = this.email;
    data['theme'] = this.theme;
    data['language'] = this.language;
    data['session_key'] = this.sessionKey;
    data['isTeacher'] = this.isTeacher;
    data['photo'] = this.photo;
    return data;
  }

  @override
  String toString() {
    return 'LoginResponse{"class": ${$class}, fullName: $fullName, email: $email, theme: $theme, language: $language, sessionKey: $sessionKey, isTeacher: $isTeacher, photo: $photo}';
  }
}
