import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:flutter/material.dart';

class HomeAttentionPage extends StatefulWidget {
  @override
  _HomeAttentionPageState createState() => _HomeAttentionPageState();
}

class _HomeAttentionPageState extends State<HomeAttentionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text(GmLocalizations.of(context).homeAttentionTitle),
      ),
    );
  }
}
