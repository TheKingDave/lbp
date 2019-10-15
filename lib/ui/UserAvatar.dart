import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String url;

  UserAvatar(this.url) : super();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage: url == null
            ? AssetImage("assets/img/default-avatar.png")
            : NetworkImage(url));
  }
}
