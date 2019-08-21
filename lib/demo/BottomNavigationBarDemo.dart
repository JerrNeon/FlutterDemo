import 'package:flutter/material.dart';

import '../email/EmailScreen.dart';
import '../home/HomeScreen.dart';
import '../pages/PagesScreen.dart';
import '../airplay/AirplayScreen.dart';

class BottomNavigationBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter bottomNavigationBar",
      theme: ThemeData.light(),
      home: BottomNavigatorWidget(),
    );
  }
}

class BottomNavigatorWidget extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigatorWidget> {
  final _bottomNavigatorColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list
      ..add(HomeScreen())
      ..add(EmailScreen())
      ..add(PagesScreen())
      ..add(AirplayScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _bottomNavigatorColor),
              title: Text(
                "Home",
                style: TextStyle(color: _bottomNavigatorColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.email, color: _bottomNavigatorColor),
              title: Text(
                "Email",
                style: TextStyle(color: _bottomNavigatorColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.pages, color: _bottomNavigatorColor),
              title: Text(
                "Pages",
                style: TextStyle(color: _bottomNavigatorColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplay, color: _bottomNavigatorColor),
              title: Text(
                "Airplay",
                style: TextStyle(color: _bottomNavigatorColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
