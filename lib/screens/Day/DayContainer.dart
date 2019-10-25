import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';
import 'package:redux/redux.dart';

import 'DayScaffold.dart';

class DayContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        DayRouteData data = ModalRoute.of(context).settings.arguments;
        List<Class> classes = classesOfDaySelector(store.state, data.day);

        return DayScaffold(
          classes: classes,
          data: data,
        );
      },
    );
  }
}