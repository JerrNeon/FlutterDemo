import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:flutter/material.dart';

class HomeCommunityPage extends StatefulWidget {
  @override
  _HomeCommunityPageState createState() => _HomeCommunityPageState();
}

class _HomeCommunityPageState extends State<HomeCommunityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text(GmLocalizations.of(context).homeCommunityTitle),
      ),
    );
  }
}
