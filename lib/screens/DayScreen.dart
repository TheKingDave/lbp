import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';

class DayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int day = ModalRoute.of(context).settings.arguments;

    return StoreConnector<AppState, _DayScreenData>(
      converter: (store) => _DayScreenData(),
      builder: (context, model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Text("08:00 AM - 10:40 AM"),
                Text("10:40 AM - 01:20 AM"),
              ],
            ),
            Container(color: Colors.green, padding: EdgeInsets.all(30))
          ],
        );
      },
    );
  }
}

class _DayScreenData {

}