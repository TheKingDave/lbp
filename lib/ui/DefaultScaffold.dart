import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/helpers.dart';
import 'package:lbp/ui/NavDrawer.dart';

class DefaultScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context, {Widget child}) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
      ),
    );
  }
}
