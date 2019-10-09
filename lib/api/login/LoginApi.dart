import 'package:http/http.dart' as http;
import 'package:lbp/helpers.dart';

Future<bool> login(String username, String password) async {
  final sendObj = {
    "username": encode(username),
    "password": encode(password),
  };

  cPrint("Send msg");

  var res = await http.post("https://lb-planer.tgm.ac.at/api/v1/login",
      body: sendObj);

  cPrint("Status ${res.statusCode}");
  cPrint(res.body);

  return true;
}