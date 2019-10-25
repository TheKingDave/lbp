import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/logic/DayRouteData.dart';
import 'package:lbp/screens/Day/DayScreen.dart';
import 'package:lbp/ui/NavDrawer.dart';

class DayScaffold extends StatefulWidget {
  final List<Class> classes;
  final DayRouteData data;

  const DayScaffold({Key key, @required this.classes, @required this.data})
      : super(key: key);

  @override
  _DayScaffoldState createState() =>
      _DayScaffoldState(classes: classes, data: data);
}

class _DayScaffoldState extends State<DayScaffold>
    with SingleTickerProviderStateMixin {
  final List<Class> classes;
  final DayRouteData data;

  TabController _tabController;

  _DayScaffoldState({@required this.classes, @required this.data});

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: data.initialLesson, vsync: this, length: classes.length);
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

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
          children: List.from(classes.map((c) => DayScreen(
            weekDay: data.day,
            $class: index++,
          ))),
        ));
  }
}

class _DayScaffoldData {}
