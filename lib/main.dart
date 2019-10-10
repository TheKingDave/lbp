import 'package:flutter/material.dart';
import 'package:lbp/api/strings/DefaultStrings.dart';
import 'package:lbp/screens/OverviewScreen.dart';
import 'package:lbp/screens/SettingsScreen.dart';
import 'package:lbp/ui/DefaultScaffold.dart';
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
        '/': (context) => LoginScreen(),
        '/overview': (context) => DefaultScaffold(name: "Overview", child: OverviewScreen()),
        '/settings': (context) => DefaultScaffold(name: "Settings", child: SettingsScreen()),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF2A47E4),
      ),
    );
  }
}