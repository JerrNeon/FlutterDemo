import 'package:flutter/material.dart';
import 'package:flutter_demo/common/global.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatefulWidget {
  @override
  _ThemeChangeRouteState createState() => _ThemeChangeRouteState();
}

class _ThemeChangeRouteState extends State<ThemeChangeRoute> {
  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((color) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Container(
                color: color,
                height: 40,
              ),
            ),
            onTap: () =>
                //主题更新后，MaterialApp会重新build
                Provider.of<ThemeModel>(context).theme = color,
          );
        }).toList(),
      ),
    );
  }
}
