import 'package:child_star/common/my_systems.dart';
import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/dialog_utils.dart';
import 'package:child_star/widgets/appbar_widget.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MineSetPage extends StatefulWidget {
  @override
  _MineSetPageState createState() => _MineSetPageState();
}

class _MineSetPageState extends State<MineSetPage> {
  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: MyColors.c_fafafa,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(gm.mineSetTitle),
            _buildBody(gm),
            Divider(
              height: MySizes.s_1,
              color: MyColors.c_c1c1c1,
            ),
            _buildLogout(gm),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(GmLocalizations gm) {
    final textList = <String>[
      gm.mineSetPush,
      gm.mineSetGeneral,
      gm.mineSetAboutUs,
      gm.mineSetFeedback,
    ];
    return ListView.separated(
      shrinkWrap: true,
      itemCount: textList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: MySizes.s_14,
            top: MySizes.s_20,
            right: MySizes.s_10,
            bottom: MySizes.s_20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                textList[index],
                style: TextStyle(
                  color: MyColors.c_777777,
                  fontSize: MyFontSizes.s_15,
                ),
              ),
              Image(image: MyImages.ic_mine_arrow),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: MySizes.s_1,
          color: MyColors.c_c1c1c1,
        );
      },
    );
  }

  Widget _buildLogout(GmLocalizations gm) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLogin) {
      return Expanded(
        child: GestureDetector(
          onTap: () => _logout(gm),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Positioned(
                bottom: MySizes.s_74,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: MyColors.c_dadada, width: MySizes.s_1),
                    borderRadius: BorderRadius.circular(MySizes.s_16),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MySizes.s_38,
                    vertical: MySizes.s_8,
                  ),
                  child: Text(
                    gm.mineSetLogout,
                    style: TextStyle(
                      color: MyColors.c_8a8a8a,
                      fontSize: MyFontSizes.s_14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return EmptyWidget();
    }
  }

  _logout(GmLocalizations gm) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    showCupertinoAlertDialog(
      context,
      content: gm.mineSetLogoutDialogContent,
      onPositiveTap: () async {
        try {
          await NetManager(context).logout();
          userProvider.user = null;
          showToast(gm.mineSetLogoutSuccess);
          Navigator.of(context).pop();
        } catch (e) {}
      },
    );
  }
}
