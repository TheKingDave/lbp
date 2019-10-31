import 'package:flutter/material.dart';
import 'package:flutter_autofill/flutter_autofill.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/states/FetchState.dart';
import 'package:lbp/ui/ErrorNotifier.dart';
import 'package:lbp/ui/LoadingButton.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.getCapitalize("login")),
          actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
        ),
        body: ErrorNotifier(
            child: Container(

      child: _LoginScreen(),
    )));
  }
}

class _LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _formCommitted = false;
  bool _autoFillCommitted = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    if (!_autoFillCommitted) {
      // Potential error source. In original docs called with `await`
      FlutterAutofill.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _LoginScreenModel>(
      distinct: true,
      converter: (store) => _LoginScreenModel(
          state: store.state.login,
          login: (un, pw) =>
              store.dispatch(ApiLoginAction(username: un, password: pw))),
      builder: (context, model) {
        final loading = model.state.loading;

        final _login = ([dynamic _]) async {
          if (loading) {
            return;
          }
          _formCommitted = true;
          if (_formKey.currentState.validate()) {
            final un = _usernameController.text;
            final pw = _passwordController.text;

            await FlutterAutofill.commit();
            model.login(un, pw);
          }
        };

        return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        Strings.getGreetingString(TimeOfDay.now().hour),
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(top: 16.0)),
                    Autofill(
                        onAutofilled: (val) {
                          _usernameController.value = TextEditingValue(
                            text: val,
                          );
                        },
                        autofillHints: [FlutterAutofill.AUTOFILL_HINT_USERNAME],
                        autofillType: FlutterAutofill.AUTOFILL_TYPE_TEXT,
                        textController: _usernameController,
                        child: TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: _usernameFocus,
                          decoration: InputDecoration(
                            labelText: Strings.getCapitalize("username"),
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (term) {
                            _usernameFocus.unfocus();
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                          autovalidate: true,
                          validator: (value) {
                            if (!_formCommitted) return null;
                            if (value.contains('@')) {
                              return 'Please enter your shorthand. Not your email.';
                            }
                            if (value.isEmpty) {
                              return 'Please enter your username.';
                            }
                            return null;
                          },
                        )),
                    Padding(padding: EdgeInsets.only(top: 16.0)),
                    Autofill(
                        onAutofilled: (val) {
                          _passwordController.value = TextEditingValue(
                            text: val,
                          );
                        },
                        autofillHints: [FlutterAutofill.AUTOFILL_HINT_PASSWORD],
                        autofillType: FlutterAutofill.AUTOFILL_TYPE_TEXT,
                        textController: _passwordController,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          focusNode: _passwordFocus,
                          onFieldSubmitted: _login,
                          decoration: InputDecoration(
                            labelText: Strings.getCapitalize("password"),
                            border: OutlineInputBorder(),
                          ),
                          autovalidate: true,
                          validator: (value) {
                            if (!_formCommitted) return null;
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        )),
                    Padding(padding: EdgeInsets.only(top: 16.0)),
                    ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: LoadingButton(
                          loading: loading,
                          padding: EdgeInsets.all(loading ? 8 : 16),
                          onPressed: _login,
                          child: Text(Strings.getCapitalize("login")),
                        )),
                  ],
                )));
      },
    );
  }
}

class _LoginScreenModel {
  final FetchState<LoginData> state;
  final void Function(String username, String password) login;

  _LoginScreenModel({this.state, this.login});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _LoginScreenModel &&
          runtimeType == other.runtimeType &&
          state == other.state &&
          login == other.login;

  @override
  int get hashCode => state.hashCode ^ login.hashCode;
}
