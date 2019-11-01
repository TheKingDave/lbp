import 'package:flutter/material.dart';
import 'package:lbp/data/strings/Strings.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final name = ModalRoute.of(context).settings.name;

    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.getCapitalize("a_not_found_page")),
          actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.info_outline, color: t.errorColor, size: 150),
                Text(Strings.getCapitalize("a_not_found_page_text"),
                    style: t.textTheme.headline),
                Text("Route: $name"),
                RaisedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                  label: Text(Strings.getCapitalize("a_go_back")),
                ),
              ],
            ),
          ),
        ));
  }
}
