import 'package:flutter/material.dart';
import 'package:lbp/api/login/LoginApi.dart';
import 'package:lbp/api/strings/Strings.dart';
import 'package:lbp/helpers.dart';

class LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
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
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: Strings.getString("username"),
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
                        labelText: Strings.getString("password"),
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
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final un = _usernameController.text;
                          final pw = _passwordController.text;

                          cPrint("Testing");

                          await login(un, pw);
                        }
                      },
                      child: Text(Strings.getString("login")),
                    ),
                  ],
                ))));
  }
}

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}
