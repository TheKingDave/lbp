String encode(String s, [int e = 1337]) {
  String o = "";
  s.runes.forEach((int i) {
    o += String.fromCharCode(i ^ e);
  });
  return o;
}

void cPrint(dynamic msg) {
  print("c-log ${msg.toString()}");
}