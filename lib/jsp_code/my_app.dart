import 'package:flutter/material.dart';

import 'demo/BottomAppBarDemo.dart';
import 'demo/BottomNavigationBarDemo.dart';
import 'demo/ClipPathDemo.dart';
import 'demo/DraggableDemo.dart';
import 'demo/ExpandTitleDemo.dart';
import 'demo/ExpansionPanelListDemo.dart';
import 'demo/FrostedGlassDemo.dart';
import 'demo/Home.dart';
import 'demo/RightSlipBackDemo.dart';
import 'demo/RouteAnimationDemo.dart';
import 'demo/SearchBarDemo.dart';
import 'demo/SplashDemo.dart';
import 'demo/TabBarDemo.dart';
import 'demo/ToolTipDemo.dart';
import 'demo/WrapLayoutDemo.dart';

class MyAppWidgetDemo extends StatefulWidget {
  @override
  _MyAppWidgetDemoState createState() => _MyAppWidgetDemoState();
}

class _MyAppWidgetDemoState extends State<MyAppWidgetDemo> {
  List<Widget> list = List();
  List<String> listStr = List();

  @override
  void initState() {
    list
      ..add(Home())
      ..add(BottomNavigationBarDemo())
      ..add(BottomAppBarDemo())
      ..add(RouteAnimationDemo())
      ..add(FrostedGlassDemo())
      ..add(TabBarDemo())
      ..add(SearchBarDemo())
      ..add(WrapLayoutDemo())
      ..add(ExpandTitleDemo())
      ..add(ExpansionPanelListDemo())
      ..add(ClipPathDemo())
      ..add(SplashDemo())
      ..add(RightSlipBackDemo())
      ..add(ToolTipDemo())
      ..add(DraggableDemo());

    listStr
      ..add("Home")
      ..add("BottomNavigationBarDemo")
      ..add("BottomAppBarDemo")
      ..add("RouteAnimationDemo")
      ..add("FrostedGlassDemo")
      ..add("TabBarDemo")
      ..add("SearchBarDemo")
      ..add("WrapLayoutDemo")
      ..add("ExpandTitleDemo")
      ..add("ExpansionPanelListDemo")
      ..add("ClipPathDemo")
      ..add("SplashDemo")
      ..add("RightSlipBackDemo")
      ..add("ToolTipDemo")
      ..add("DraggableDemo");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("MyAppDemo"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(listStr[index]),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => list[index]));
            },
          ),
        ),
        itemCount: list.length,
      ),
    );
  }
}
