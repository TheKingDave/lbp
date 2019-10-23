import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool loading;
  final Widget Function(BuildContext context) _build;

  Loader({this.loading, build}) : this._build = build;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        alignment: Alignment(0, 0),
        child: CircularProgressIndicator(),
      );
    } else {
      return _build(context);
    }
  }
}
