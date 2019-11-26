import 'package:child_star/common/my_images.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _TopBarWidget(),
          Container(
            color: Colors.pinkAccent,
            child: Text("11111111111111111111111"),
          )
        ],
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Image(image: MyImages.ic_home_personal),
            onPressed: () {
              showToast("home");
            }),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(gm.homeNewTitle),
            Text(gm.homeAttentionTitle),
            Text(gm.homeCommunityTitle),
          ],
        ),
        IconButton(
            icon: Image(image: MyImages.ic_home_message),
            onPressed: () {
              showToast("consultation");
            }),
      ],
    );
  }
}
