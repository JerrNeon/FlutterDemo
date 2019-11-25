import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("home$_index"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _index++;
            });
          }),
    );
  }
}
