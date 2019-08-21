import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/BottomAppBarDemo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: new Center(
          child: new GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomAppBarDemo()));
        },
        child: Text("Home"),
      )),
    );
  }
}
