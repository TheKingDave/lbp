import 'dart:convert';
import 'package:http/http.dart' as http;

String encode(String s, [int e = 1337]) {
  String o = "";
  s.runes.forEach((int i) {
    o += String.fromCharCode(i ^ e);
  });
  return o;
}

Future<void> main() async {
  String user = "dlangheiter";
  String pass = "300420Ele,.Dave";

  final sendObj = {
    "username": encode(user),
    "password": encode(pass),
  };

  var res = await http.post("https://lb-planer.tgm.ac.at/api/v1/login",
      body: sendObj);

  if (res.statusCode != 200) {
    print("Status not 200 but ${res.statusCode}");
    print(res.body);
    return;
  }

  final sessObj = {
    "sess_key": jsonDecode(res.body)['session_key'],
  };

  res = await http.post("https://lb-planer.tgm.ac.at/api/v1/getData",
      body: sessObj);

  print(res.body);
}
