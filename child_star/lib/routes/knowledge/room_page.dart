import 'package:child_star/i10n/i10n_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(GmLocalizations.of(context).homeCommunityTitle),
      ),
    );
  }
}
