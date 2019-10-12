import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/etc/Languages.dart';
import 'package:lbp/etc/helpers.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = Api
      .get()
      .settings
      .getBool("darkmode") ?? false;

  Language _language = Language(Api
      .get()
      .settings
      .getString("language") ?? "en");

  void _setDarkMode(bool value) {
    setState(() {
      _darkMode = value;
      Api
          .get()
          .settings
          .setBool("darkmode", value);
    });
  }

  void _setLanguage(Language lang) {
    if(lang == null) return;
    setState(() {
      _language = lang;
      Api
          .get()
          .settings
          .setString("language", lang.short);
    });
  }

  Future<void> _selectLanguage() async {
    Language lang = await showDialog<Language>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Select Langauge"),
            children: Language.languages.map((lang) {
              return ListTile(
                title: Text(lang.name),
                onTap: () {
                  Navigator.pop(context, lang);
                },
              );
            }).toList(),
          );
        }
    );
    _setLanguage(lang);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Dark mode"),
          leading: Icon(Icons.brightness_2),
          onTap: () => _setDarkMode(!_darkMode),
          trailing: Switch(
            value: _darkMode,
            onChanged: _setDarkMode,
          ),
        ),
        ListTile(
          title: Text("Language"),
          subtitle: Text(_language.name),
          leading: Icon(Icons.language),
          onTap: _selectLanguage,
        ),
      ],
    );
  }

}