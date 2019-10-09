import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/helpers.dart';

class DefaultScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context, {Widget child}) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => cPrint("Menu pressed"),
        ),
        actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
      ),
    );
  }
}
