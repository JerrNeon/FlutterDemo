import 'package:flutter/material.dart';

class ExpandTitleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ExpandTitleDemo",
      theme: ThemeData.light(),
      home: ExpandTitleWidget(),
    );
  }
}

class ExpandTitleWidget extends StatefulWidget {
  @override
  _ExpandTitleWidgetState createState() => _ExpandTitleWidgetState();
}

class _ExpandTitleWidgetState extends State<ExpandTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ExpandTitleDemo"),
      ),
      body: Center(
        child: ExpansionTile(
          title: Text("Expansion Title"),
          leading: Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,
          children: <Widget>[
            ListTile(
              title: Text("list title"),
              subtitle: Text("sub title"),
            )
          ],
          initiallyExpanded: true,
        ),
      ),
    );
  }
}
