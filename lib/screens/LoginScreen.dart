import 'package:flutter/material.dart';
import 'package:lbp/api/Api.dart';
import 'package:lbp/api/login/LoginRequest.dart';
import 'package:lbp/api/strings/Strings.dart';
import 'package:lbp/etc/helpers.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 20.0, color: Theme.of(context).primaryColor))),
      child: _LoginScreen(),
    ));
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
                      return 'Please enter your shorthand. Not your email';
                    }
                    if (value.isEmpty) {
                      return 'Please enter your username';
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
                    child: RaisedButton(
                      padding: EdgeInsets.all(16),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final un = _usernameController.text;
                          final pw = _passwordController.text;

                          final res = await Api.get()
                              .login(LoginRequest(username: un, password: pw));

                          if (res.hasError()) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(res.error),
                              backgroundColor: Color(0xffc83b2e),
                            ));
                          } else {
                            Navigator.pushNamed(context, "/overview");
                          }
                        }
                      },
                      child: Text(Strings.getCapitalize("login")),
                    )),
              ],
            )));
  }
}