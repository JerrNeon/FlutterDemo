import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightSlipBackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RightSlipBackDemo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RightSlipBackWidget(),
    );
  }
}

class RightSlipBackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.blue,
        middle: Text(
          "侧滑返回",
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          color: CupertinoColors.activeBlue,
          child: CupertinoButton(
              child: Icon(CupertinoIcons.add),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => RightSlipBackSecondWidget()));
              }),
        ),
      ),
    );
  }
}

class RightSlipBackSecondWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "侧滑返回",
        theme: ThemeData(primarySwatch: Colors.blue),
        color: Colors.white,
        home: Scaffold(
          appBar: AppBar(
            title: Text("此界面可侧滑返回"),
          ),
        ));
  }
}
