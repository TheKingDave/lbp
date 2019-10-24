import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/ui/NavDrawer.dart';

class DefaultScaffold extends StatelessWidget {

  final String name;
  final Widget child;

  DefaultScaffold({this.name, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: name != null ? Text(name) : null,
        actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
      ),
      body: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
