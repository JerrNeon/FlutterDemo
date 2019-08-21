import 'package:flutter/material.dart';

class BottomAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BottomAppBarDemo",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: BottomAppBarDemoFul(),
    );
  }
}

class BottomAppBarDemoFul extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BottomAppBarDemoFul> {
  List<Widget> list = List();
  int index = 0;

  @override
  void initState() {
    super.initState();
    list..add(EachView("Home"))..add(EachView("Me"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new EachView("New Page")));
        },
        tooltip: "Increment",
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.airport_shuttle),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EachView extends StatefulWidget {
  final String title;

  EachView(this.title);

  @override
  _EachViewState createState() => _EachViewState();
}

class _EachViewState extends State<EachView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
