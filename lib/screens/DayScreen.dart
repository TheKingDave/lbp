import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/redux/AppState.dart';

class DayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String dayName = ModalRoute.of(context).settings.arguments;

    return StoreConnector<AppState, _DayScreenData>(
      converter: (store) => _DayScreenData(),
      builder: (context, model) {
        return Text(dayName);
      },
    );
  }
}

class _DayScreenData {

}