import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/BottomAppBarDemo.dart';
import 'package:flutter_demo/demo/ExpandTitleDemo.dart';
import 'package:flutter_demo/demo/Home.dart';
import 'package:flutter_demo/demo/SearchBarDemo.dart';
import 'package:flutter_demo/demo/TabBarDemo.dart';
import 'package:flutter_demo/demo/WrapLayoutDemo.dart';

import 'demo/BottomNavigationBarDemo.dart';
import 'demo/ExpansionPanelListDemo.dart';
import 'demo/FrostedGlassDemo.dart';
import 'demo/RouteAnimationDemo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false, //去掉DeBug图标
      home: MyAppWidget(),
    );
  }
}

class MyAppWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppWidget> {
  List<Widget> list = List();
  List<String> listStr = List();

  @override
  void initState() {
    list
      ..add(BottomNavigationBarDemo())
      ..add(BottomAppBarDemo())
      ..add(RouteAnimationDemo())
      ..add(FrostedGlassDemo())
      ..add(TabBarDemo())
      ..add(SearchBarDemo())
      ..add(WrapLayoutDemo())
      ..add(ExpandTitleDemo())
      ..add(ExpansionPanelListDemo())
      ..add(Home());

    listStr
      ..add("BottomNavigationBarDemo")
      ..add("BottomAppBarDemo")
      ..add("RouteAnimationDemo")
      ..add("FrostedGlassDemo")
      ..add("TabBarDemo")
      ..add("SearchBarDemo")
      ..add("WrapLayoutDemo")
      ..add("ExpandTitleDemo")
      ..add("ExpansionPanelListDemo")
      ..add("Other");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("MyApp"),
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
