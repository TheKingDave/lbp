import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/api/Api.dart';

class UserAvatar extends StatelessWidget {
  static const defaultImg = "/api/v1/avatars/default-avatar.png";
  static const gravatarUrl = "https://www.gravatar.com/avatar/{md5}/?d={d}";
  static final calcGravatarUrl = gravatarUrl.replaceAll(
      new RegExp(r"{d}"), Uri.encodeQueryComponent(Api.get().getUrl(defaultImg)));

  final String url;
  final String email;

  UserAvatar(this.url, [this.email]) : super();

  @override
  Widget build(BuildContext context) {
    Api api = Api.get();

    String actUrl = url;

    /*
    if (url == defaultImg && email != null) {
      String md5Hash = md5.convert(utf8.encode(email)).toString();
      actUrl = calcGravatarUrl.replaceAll("{md5}", md5Hash);
      cPrint(actUrl);
    }
     */

    return CircleAvatar(
        backgroundImage: actUrl != null ? NetworkImage(api.getUrl(actUrl)) : null);
  }
}
