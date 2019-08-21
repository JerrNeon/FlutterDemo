import 'package:flutter/material.dart';
import 'package:flutter_demo/route/customer_router.dart';

class RouteAnimationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RouteAnimationDemo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: new FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Fitst Page", style: TextStyle(fontSize: 36.0)),
        elevation: 0,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context, CustomerRoute(SecondPage(),CustomerRoute.ANIMATION_SLIDE_LEFT_RIGHT));
          },
          child: Icon(Icons.navigate_next, color: Colors.white, size: 64),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text("SecondPage", style: TextStyle(fontSize: 36.0)),
        backgroundColor: Colors.pinkAccent,
        leading: Container(),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.navigate_before, color: Colors.white, size: 64),
        ),
      ),
    );
  }
}
