import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  static const defaultImg = "/api/v1/avatars/default-avatar.png";

  final String url;

  UserAvatar(this.url) : super();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage: url != null ? NetworkImage(url) : null);
  }
}
