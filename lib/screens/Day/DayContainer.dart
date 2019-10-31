import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';
import 'package:redux/redux.dart';

import 'DayScaffold.dart';

class DayContainer extends StatelessWidget {
  final DayRouteData dayRouteData;

  DayContainer(this.dayRouteData);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        List<Class> classes = classesOfDaySelector(store.state, dayRouteData.day);

        return DayScaffold(
          classes: classes,
          data: dayRouteData,
        );
      },
    );
  }
}