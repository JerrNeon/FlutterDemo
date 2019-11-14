import 'package:flutter/material.dart';

class DemoStateWidget extends StatefulWidget {
  final String text;

  DemoStateWidget(this.text);

  @override
  State<StatefulWidget> createState() {
    return _DemoStateWidgetState(text);
  }
}

class _DemoStateWidgetState extends State<DemoStateWidget> {
  String text;

  _DemoStateWidgetState(this.text);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        text = "这就改变了数值";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("有状态Demo"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          height: 120.0,
          width: 500.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: Colors.orange,
              border: Border.all(
                color: Colors.grey,
                width: 0.3,
              )),
          child: Text(
            text ?? "这就是有状态的Demo",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
