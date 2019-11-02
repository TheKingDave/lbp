import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/Language.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/GeneralActions.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/selectors/GeneralSelectors.dart';

class SettingsScreen extends StatelessWidget {
  Future<Language> _selectLanguage(BuildContext context, Language current) {
    return showDialog<Language>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Select Langauge"),
            children: Language.languages.map((lang) {
              return RadioListTile<Language>(
                title: Text(lang.name),
                value: lang,
                groupValue: current,
                onChanged: (lang) {
                  Navigator.pop(context, lang);
                },
              );
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _State>(
      converter: (store) => _State(
        language: languageSelector(store.state),
        darkMode: darkModeSelector(store.state),
        setDarkMode: (darkMode) => store.dispatch(SetDarkModeAction(darkMode)),
        setLanguage: (lang) => store.dispatch(SetLanguageAction(lang)),
      ),
      builder: (context, state) {
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text("Dark mode"),
              leading: Icon(Icons.brightness_2),
              onTap: () => state.setDarkMode(!state.darkMode),
              trailing: Switch(
                value: state.darkMode,
                onChanged: state.setDarkMode,
              ),
            ),
            ListTile(
              title: Text(Strings.getCapitalize("language")),
              subtitle: Text(state.language.name),
              leading: Icon(Icons.language),
              onTap: () async {
                final lang = await _selectLanguage(context, state.language);
                if (lang != null) state.setLanguage(lang);
              },
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
  Function(bool darkMode) setDarkMode;
  Function(Language language) setLanguage;

  _State({this.language, this.darkMode, this.setDarkMode, this.setLanguage});
}
