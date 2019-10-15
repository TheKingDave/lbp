import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/states/FetchState.dart';
import 'package:lbp/ui/ErrorNotifier.dart';

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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Guten Nachmitag',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: Strings.getCapitalize("username"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.contains('@')) {
                      return 'Please enter your shorthand. Not your email.';
                    }
                    if (value.isEmpty) {
                      return 'Please enter your username.';
                    }
                    return null;
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
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
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: new StoreConnector<AppState, _LoginScreenModel>(
                      converter: (store) => _LoginScreenModel(
                          state: store.state.login,
                          login: (un, pw) => store.dispatch(
                              ApiLoginAction(username: un, password: pw))),
                      builder: (context, model) {
                        final loading = model.state.loading;

                        return RaisedButton(
                          padding: EdgeInsets.all(loading ? 8 : 16),
                          onPressed: loading
                              ? null
                              : () async {
                                  if (_formKey.currentState.validate()) {
                                    final un = _usernameController.text;
                                    final pw = _passwordController.text;

                                    model.login(un, pw);

                                    // Navigator.pushNamed(context, "/overview");
                                  }
                                },
                          child: loading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ))
                              : Text(Strings.getCapitalize("login")),
                        );
                      },
                    )),
              ],
            )));
  }
}

class _LoginScreenModel {
  final FetchState<LoginData> state;
  final void Function(String username, String password) login;

  _LoginScreenModel({this.state, this.login});
}
