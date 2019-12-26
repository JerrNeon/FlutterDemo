import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/widgets/page/consultation_widget.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

///问诊
class InquiryPage extends StatefulWidget {
  @override
  _InquiryPageState createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage>
    with SingleTickerProviderStateMixin {
  Future<Chunyu> _future;
  TabController _tabController;
  List<String> _tabList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initFuture();
  }

  _initFuture() {
    _future = NetManager(context).getChunYuUrl();
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    _tabList ??= [
      gm.inquiryTab1Title,
      gm.inquiryTab2Title,
    ];
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            gm.inquiryTitle,
            isShowDivider: true,
          ),
          Expanded(
            child: FutureBuilderWidget<Chunyu>(
              future: _future,
              onErrorRetryTap: () {
                setState(() {
                  _initFuture();
                });
              },
              builder: (context, snapshot) {
                return Column(
                  children: <Widget>[
                    _buildTabBar(),
                    Expanded(
                      child: _buildTabBarView(gm, snapshot.data),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: _tabController.index == _tabList.length - 1
          ? MyColors.c_ffa054
          : MyColors.c_6eabb4,
      indicatorWeight: MySizes.s_3,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: TextStyle(
        fontSize: MyFontSizes.s_15,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: MyColors.c_686868,
      labelColor: _tabController.index == _tabList.length - 1
          ? MyColors.c_ffa054
          : MyColors.c_6eabb4,
      labelStyle: TextStyle(
        fontSize: MyFontSizes.s_15,
        fontWeight: FontWeight.bold,
      ),
      onTap: (_) {
        setState(() {});
      },
      tabs: _tabList
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
    );
  }

  Widget _buildTabBarView(GmLocalizations gm, Chunyu data) {
    User user = Provider.of<UserProvider>(context).user;
    return TabBarView(
      controller: _tabController,
      children: [
        _buildItem(
          gm,
          data,
          MyImages.ic_consultation_Inquiry1_cover,
          MyImages.ic_consultation_Inquiry1_describe,
          MyImagesMultiple.inquiry_status1[user.role != 0],
        ),
        _buildItem(
          gm,
          data,
          MyImages.ic_consultation_Inquiry2_cover,
          MyImages.ic_consultation_Inquiry2_describe,
          MyImagesMultiple.inquiry_status2[user.role != 0],
        ),
      ],
    );
  }

  Widget _buildItem(
    GmLocalizations gm,
    Chunyu data,
    AssetImage coverImage,
    AssetImage describeImage,
    AssetImage btnImage,
  ) {
    User user = Provider.of<UserProvider>(context).user;
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image(image: coverImage),
            SizedBox(height: MySizes.s_22),
            Image(image: describeImage),
            SizedBox(height: MySizes.s_36),
            GestureDetector(
              onTap: () {
                if (user.role == 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return InquiryDialog(
                        onBuyTap: () => _openChunYuUrlLink(data),
                        onForwardTap: () => _openChunYuUrlLink(data),
                      );
                    },
                  );
                } else {
                  _openChunYuUrlLink(data);
                }
              },
              child: Image(image: btnImage),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: MySizes.s_24,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              gm.inquiryTipsTitle,
              style: TextStyle(
                color: MyColors.c_bababa,
                fontSize: MyFontSizes.s_8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _openChunYuUrlLink(Chunyu data) {
    if (data != null) RoutersNavigate().navigateToH5(context, data.linkUrl);
  }
}
