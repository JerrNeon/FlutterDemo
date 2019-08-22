import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.light(),
      home: new _KeepAliveDemo(context),
    );
  }
}

class _KeepAliveDemo extends StatefulWidget {
  final BuildContext parentContext;

  _KeepAliveDemo(this.parentContext);

  @override
  __KeepAliveDemoState createState() => __KeepAliveDemoState();
}

/*
with是dart的关键字，意思是混入的意思，
就是说可以将一个或者多个类的功能添加到自己的类无需继承这些类，
避免多重继承导致的问题。
SingleTickerProviderStateMixin 主要是我们初始化TabController时，
需要用到vsync ，垂直属性，然后传递this
*/
class __KeepAliveDemoState extends State<_KeepAliveDemo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    //重写被释放的方法，只释放TabController
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("TabBarDemo"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              //注：这里要用父Widget的Context，否则返回会黑屏
              Navigator.pop(widget.parentContext);
            }),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
            Tab(icon: Icon(Icons.directions_walk)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text("Tab1")),
          Center(child: Text("Tab2")),
          MyHomePage(),
          MyHomePage(),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _KeepAliveFulState createState() => _KeepAliveFulState();
}

//混入AutomaticKeepAliveClientMixin，这是保持状态的关键
//然后重写wantKeppAlive 的值为true。
class _KeepAliveFulState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //重写keepAlive 为ture ，就是可以有记忆功能了。
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("点一下加1，点一下加1："),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.display1,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        tooltip: "increment",
        child: Icon(Icons.add),
      ),
    );
  }
}
