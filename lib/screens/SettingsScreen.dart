import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/etc/helpers.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchListTile(
          value: false,
          title: Text("Dark mode"),
          onChanged: (value) => cPrint("dm change to $value"),
        ),
        ListTile(
          title: Text("Language"),
          trailing: DropdownButton<String>(
            value: "English",
            onChanged: (String newValue) {
              cPrint("change $newValue}");
            },
            // icon: Icon(Icons.arrow_downward),
            items: <String>["English", "Deutsch"].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

}