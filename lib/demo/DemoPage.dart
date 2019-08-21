import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/DemoItem.dart';

class DemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DemoPageState();
  }
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Title"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return DemoItem();
        },
        itemCount: 20,
        padding: EdgeInsets.only(left: 0, top: 10.0, right: 0, bottom: 0),
      ),
    );
  }
}
