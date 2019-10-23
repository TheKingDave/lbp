import 'package:flutter/material.dart';
import 'package:flutter_autofill/flutter_autofill.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/etc/helpers.dart';
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
        body: ErrorNotifier(
            child: Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 20.0, color: Theme.of(context).primaryColor))),
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

  bool _autoFillCommitted = false;

  @override
  void dispose() async {
    _usernameController.dispose();
    _passwordController.dispose();
    if(!_autoFillCommitted) {
      await FlutterAutofill.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _LoginScreenModel>(
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
                    Text('Guten Nachmitag',
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(top: 16.0)),
                    Autofill(
                        onAutofilled: (val) {
                          _usernameController.value = TextEditingValue(
                              text: val,
                              selection: TextSelection.fromPosition(
                                  TextPosition(offset: val.lenght)));
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
                          validator: (value) {
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
                              selection: TextSelection.fromPosition(
                                  TextPosition(offset: val.lenght)));
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
                          validator: (value) {
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
