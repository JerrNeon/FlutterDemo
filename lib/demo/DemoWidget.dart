import 'package:flutter/material.dart';

class DemoWidget extends StatelessWidget {
  final String text;

  DemoWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("无状态Demo"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            text ?? "这就是无状态Demo",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ));
  }
}
