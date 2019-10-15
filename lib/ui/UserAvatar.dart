import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/api/Api.dart';

class UserAvatar extends StatelessWidget {
  static const defaultImg = "/api/v1/avatars/default-avatar.png";

  final String url;
  final String email;

  UserAvatar(this.url, [this.email]) : super();

  @override
  Widget build(BuildContext context) {
    Api api = Api.get();

    String actUrl = url;

    return CircleAvatar(
        backgroundImage: actUrl != null ? NetworkImage(api.getUrl(actUrl)) : null);
  }
}
