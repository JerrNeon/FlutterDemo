import 'package:flutter/material.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';

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
      body: Center(
        child: Text(gm.theme),
      ),
    );
  }
}
