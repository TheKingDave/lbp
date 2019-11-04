import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/Language.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/actions/GeneralActions.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:lbp/redux/selectors/GeneralSelectors.dart';

class SettingsScreen extends StatelessWidget {
  Future<Language> _selectLanguage(BuildContext context, Language current) {
    return showDialog<Language>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(Strings.getCapitalize("a_language_select")),
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
      distinct: true,
      converter: (store) => _State(
        language: languageSelector(store.state),
        darkMode: darkModeSelector(store.state),
        overviewReturn: overviewReturnSelector(store.state),
        setDarkMode: (darkMode) => store.dispatch(SetDarkModeAction(darkMode)),
        setLanguage: (lang) => store.dispatch(SetLanguageAction(lang)),
        setOverviewReturn: (or) => store.dispatch(SetOverviewReturnAction(or)),
      ),
      builder: (context, state) {
        ThemeData t = Theme.of(context);

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
            Divider(),
            ListTile(
              title: Text(Strings.getString("a_setting_overview_return")),
              subtitle: Text(Strings.getString("a_setting_overview_return_sub")),
              leading: Icon(Icons.arrow_back),
              onTap: () => state.setOverviewReturn(!state.overviewReturn),
              trailing: Switch(
                value: state.overviewReturn,
                onChanged: state.setOverviewReturn,
              ),
            )
          ],
        );
      },
    );
  }
}

class _State {
  Language language;
  bool darkMode;
  bool overviewReturn;
  Function(bool darkMode) setDarkMode;
  Function(Language language) setLanguage;
  Function(bool overviewReturn) setOverviewReturn;

  _State(
      {this.language,
      this.darkMode,
      this.overviewReturn,
      this.setDarkMode,
      this.setLanguage,
      this.setOverviewReturn});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _State &&
          runtimeType == other.runtimeType &&
          language == other.language &&
          darkMode == other.darkMode &&
          overviewReturn == other.overviewReturn &&
          setDarkMode == other.setDarkMode &&
          setLanguage == other.setLanguage &&
          setOverviewReturn == other.setOverviewReturn;

  @override
  int get hashCode =>
      language.hashCode ^
      darkMode.hashCode ^
      overviewReturn.hashCode ^
      setDarkMode.hashCode ^
      setLanguage.hashCode ^
      setOverviewReturn.hashCode;
}
