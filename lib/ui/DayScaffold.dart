import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/selectors/DaysSelectors.dart';
import 'package:lbp/ui/NavDrawer.dart';
import 'package:redux/redux.dart';

class DayScaffold extends StatefulWidget {
  const DayScaffold({Key key}) : super(key: key);

  @override
  _DayScaffoldState createState() => _DayScaffoldState();
}

class _DayScaffoldState extends State<DayScaffold>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  Widget build(BuildContext context) {
    DayRouteData data = ModalRoute.of(context).settings.arguments;
    _tabController.animateTo(data.initialLesson);

    Store<AppState> store = StoreProvider.of<AppState>(context);

    List<Class> classes = classesOfDaySelector(store.state, data.day);

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(Strings.getWeekdayString(data.day)),
          actions: <Widget>[Image(image: AssetImage("assets/img/icon.jpg"))],
          bottom: TabBar(
            controller: _tabController,
            tabs: List.from(classes.map((c) => Tab(text: c.period.toString()))),
            isScrollable: classes.length > 2,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.from(classes.map((c) => Center(
                child: Text(c.period.toString()),
              ))),
        ));
  }
}

class _DayScaffoldData {}
