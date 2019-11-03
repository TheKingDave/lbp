import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/ui/Notifier.dart';
import 'package:lbp/ui/NavDrawer.dart';

class DefaultScaffold extends StatelessWidget {
  final bool drawer;
  final String name;
  final Widget child;

  DefaultScaffold({@required this.name, this.child, this.drawer = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer ? NavDrawer() : null,
      appBar: AppBar(
        title: name != null ? Text(name) : null,
        actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
      ),
      body: Notifier(
        child: child,
      ),
    );
  }
}
