import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/api/etc/Languages.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/selectors/UserSelectors.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _setDarkMode(bool value) {

  }

  void _setLanguage(Language lang) {
    if(lang == null) return;

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
    return StoreConnector<AppState, _State>(
      converter: (store) => _State(
        language: languageSelector(store.state),
        darkMode: darkModeSelector(store.state),
      ),
      builder: (context, state) {
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text("Dark mode"),
              leading: Icon(Icons.brightness_2),
              onTap: () => _setDarkMode(!state.darkMode),
              trailing: Switch(
                value: state.darkMode,
                onChanged: _setDarkMode,
              ),
            ),
            ListTile(
              title: Text("Language"),
              subtitle: Text(state.language.name),
              leading: Icon(Icons.language),
              onTap: _selectLanguage,
            ),
          ],
        );
      },
    );
  }
}

class _State {
  Language language;
  bool darkMode;

  _State({this.language, this.darkMode});
}