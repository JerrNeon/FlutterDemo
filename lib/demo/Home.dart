import 'package:flutter/material.dart';
import 'package:flutter_demo/demo/DemoPage.dart';
import 'package:flutter_demo/demo/DemoStateWidget.dart';
import 'package:flutter_demo/demo/DemoWidget.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: AppBar(
            title: Text("Home"),
          ),
          body: ListView(
            children: <Widget>[
              _HomeItem(0),
              _HomeItem(1),
              _HomeItem(2),
            ],
          )),
    );
  }
}

class _HomeItem extends StatefulWidget{
  final int index;

  _HomeItem(this.index);

  @override
  __HomeItemState createState() => __HomeItemState();
}

class __HomeItemState extends State<_HomeItem> {
  var list = ["无状态Demo", "有状态Demo", "ListView"];

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      onPressed: () {
        switch (widget.index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DemoWidget(null)));
            break;
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DemoStateWidget(null)));
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DemoPage()));
            break;
          default:
            break;
        }
      },
      child: Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
              list[widget.index],
              style: TextStyle(color: Colors.black38, fontSize: 14),
            ),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

