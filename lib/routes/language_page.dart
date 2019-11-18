import 'package:flutter/material.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';

class LanguageRoute extends StatefulWidget {
  @override
  _LanguageRouteState createState() => _LanguageRouteState();
}

class _LanguageRouteState extends State<LanguageRoute> {
  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: Center(
        child: Text(gm.language),
      ),
    );
  }
}
