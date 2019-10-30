import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lbp/etc/helpers.dart';

class OpenSourceLicenseScreen extends StatefulWidget {
  @override
  _OpenSourceLicenseScreenState createState() =>
      _OpenSourceLicenseScreenState();
}

class _OpenSourceLicenseScreenState extends State<OpenSourceLicenseScreen> {
  Future<List<_osl>> oslData;

  @override
  void initState() {
    super.initState();

    oslData = Future(() async {
      final data = await rootBundle.loadString("assets/osl.txt", cache: false);

      List<_osl> ret = List<_osl>();

      List<String> lines = data.split("\n");

      for (String line in lines) {
        if (line.trim().isEmpty || line == null) {
          continue;
        }
        if (line.startsWith("# ")) {
          ret.add(_osl(name: line.substring(2)));
        } else if (line.startsWith("- ")) {
          ret.last.url = line.substring(2);
        } else {
          ret.last.license += line;
          ret.last.license += "\n";
        }
      }

      return ret;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: oslData,
        builder: (BuildContext context, AsyncSnapshot<List<_osl>> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // data loaded:
            return ListView(
              children: List.from(snapshot.data.map((osl) => ExpansionTile(
                    title: Text(osl.name),
                    children: <Widget>[
                      Text(osl.url,
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(osl.license),
                      )
                    ],
                  ))),
            );
          }
        });
  }
}

class _osl {
  String name;
  String url;
  String license;

  _osl({this.name, this.url, this.license = ""});
}
