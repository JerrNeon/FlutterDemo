import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        children: <Widget>[
          AppBarWidget(gm.mineTitle),
          Expanded(
            child: _UserInfoWidget(gm),
          ),
        ],
      ),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  final GmLocalizations gm;
  const _UserInfoWidget(
    this.gm, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserWidget(
      child: Container(
        color: MyColors.c_f3f2f1,
        child: Padding(
          padding: const EdgeInsets.only(
            left: MySizes.s_5,
            top: MySizes.s_5,
            right: MySizes.s_5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserProvider>(builder: (context, value, child) {
                User user = value.user;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeader(user, context),
                    _buildBody(context, user, gm),
                  ],
                );
              }),
              _buildAd(),
              _buildList(gm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(User user, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () =>
                  RoutersNavigate().navigateToModifyUserInfoPage(context),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  loadImage(
                    user.headUrl,
                    shape: BoxShape.circle,
                    width: MySizes.s_60,
                    height: MySizes.s_60,
                  ),
                  Image(image: MyImages.ic_mine_edit),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MySizes.s_14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    user.nickName,
                    style: TextStyle(
                      color: MyColors.c_777777,
                      fontSize: MyFontSizes.s_16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: MySizes.s_8),
                    child: Image(image: MyImages.ic_mine_vip),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () => RoutersNavigate().navigateToMineSet(context),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_10),
                child: Image(image: MyImages.ic_mine_set),
              ),
            ),
            GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: MySizes.s_10),
                child: Image(image: MyImages.ic_mine_message),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context, User user, GmLocalizations gm) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySizes.s_24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //我的关注
          Expanded(
            child: GestureDetector(
              onTap: () => RoutersNavigate().navigateToMyAttentionPage(context),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        user.followCount.toString(),
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySizes.s_6),
                        child: Image(
                          image: MyImages.ic_mine_focus,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: MySizes.s_8),
                    child: Text(
                      gm.mineFocus,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MySizes.s_1,
            height: MySizes.s_32,
            color: MyColors.c_c8c8c8,
          ),
          //积分规则
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${user.score.toString()} ${gm.mineScoreUnit}",
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySizes.s_4),
                        child: Image(
                          image: MyImages.ic_mine_score,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: MySizes.s_8),
                    child: Text(
                      gm.mineScore,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MySizes.s_1,
            height: MySizes.s_32,
            color: MyColors.c_c8c8c8,
          ),
          //充值点数
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${user.points.toString()} ${gm.minePointUnit}",
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySizes.s_4),
                        child: Image(
                          image: MyImages.ic_mine_point,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MySizes.s_8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: MySizes.s_8, vertical: MySizes.s_2),
                    decoration: BoxDecoration(
                      color: MyColors.c_e6e6e6,
                      borderRadius: BorderRadius.circular(MySizes.s_7),
                    ),
                    child: Text(
                      gm.minePoint,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAd() {
    return Padding(
      padding: EdgeInsets.only(bottom: MySizes.s_5),
      child: AdWidget(),
    );
  }

  Widget _buildList(GmLocalizations gm) {
    final imageList = <AssetImage>[
      MyImages.ic_mine_equity,
      MyImages.ic_mine_course,
      MyImages.ic_mine_mall,
      MyImages.ic_mine_order,
      MyImages.ic_mine_book,
      MyImages.ic_mine_download,
      MyImages.ic_mine_course,
    ];
    final textList = <String>[
      gm.mineEquity,
      gm.mineCourse,
      gm.mineMall,
      gm.mineOrder,
      gm.mineBook,
      gm.mineDownload,
      gm.mineCollection,
    ];
    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handlerListClick(context, index),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(
                left: MySizes.s_14,
                top: MySizes.s_14,
                right: MySizes.s_10,
                bottom: MySizes.s_14,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: imageList[index],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MySizes.s_14),
                        child: Text(
                          textList[index],
                          style: TextStyle(
                            color: MyColors.c_777777,
                            fontSize: MyFontSizes.s_15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image(image: MyImages.ic_mine_arrow),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: MySizes.s_1,
            color: MyColors.c_c1c1c1,
          );
        },
      ),
    );
  }

  _handlerListClick(BuildContext context, int index) {
    var routersNavigate = RoutersNavigate();
    switch (index) {
      case 0: //我的权益
        break;
      case 1: //我的课程
        routersNavigate.navigateToMyCoursePage(context);
        break;
      case 2: //福利商城
        break;
      case 3: //我的订单
        routersNavigate.navigateToMyOrderPage(context);
        break;
      case 4: //绘本书籍
        break;
      case 5: //离线缓存
        break;
      case 6: //我的收藏
        routersNavigate.navigateToMyCollectionPage(context);
        break;
      default:
        break;
    }
  }
}
