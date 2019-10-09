import 'package:flutter/material.dart';
import 'package:lbp/api/strings/DefaultStrings.dart';
import 'package:lbp/screens/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DefaultStrings.setDefaultString();
    return MaterialApp(
      title: 'Lernbüro Planer',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreenScaffold(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF2A47E4),
      ),
    );
  }
}