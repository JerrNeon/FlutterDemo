import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/news.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class ConsultationPage extends StatefulWidget {
  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> _tabList;
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _tabList ??= [
      GmLocalizations.of(context).consultationEncyclopediaTitle,
      GmLocalizations.of(context).consultationQuestionTitle,
    ];
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildHeader(),
              _buildTabBar(),
            ];
          },
          body: _buildTabBarView(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: MySizes.s_248,
        maxHeight: MySizes.s_248,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: MyImages.ic_consulation_ask,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: MyImages.ic_consulation_growth,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: MyImages.ic_consulation_vaccine,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: MySizes.s_4),
              child: SearchWidget(
                text: GmLocalizations.of(context).consultationSearchHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: TabBarSliverPersistentHeaderDelegate(
        TabBar(
          controller: _tabController,
          indicatorColor: MyColors.c_ffa2b1,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: MySizes.s_3,
          labelColor: MyColors.c_ffa2b1,
          labelStyle: TextStyle(
            fontSize: MyFontSizes.s_15,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: MyColors.c_686868,
          unselectedLabelStyle: TextStyle(
            fontSize: MyFontSizes.s_15,
            fontWeight: FontWeight.bold,
          ),
          tabs: _tabList.map((e) => Tab(text: e)).toList(),
          onTap: (index) {
            if (index == _tabList.length - 1) {
              _tabController.index = 0;
            }
          },
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SmartRefresherWidget<News>.list(
          enablePullUp: false,
          keepAlive: true,
          onRefreshLoading: (pageIndex) =>
              NetManager(context).getNewsList(pageIndex, type: 3),
          listItemBuilder: (context, index, data) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => RoutersNavigate()
                .navigateToNewDetail(context, data.id.toString()),
            child: _buildItem(data),
          ),
        ),
        EmptyWidget(),
      ],
    );
  }

  Widget _buildItem(News data) {
    return Padding(
      padding: EdgeInsets.only(
          left: MySizes.s_10,
          top: MySizes.s_9,
          right: MySizes.s_14,
          bottom: MySizes.s_4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          loadImage(
            data.headUrl,
            width: MySizes.s_60,
            height: MySizes.s_60,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(MySizes.s_4),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MySizes.s_12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    style: TextStyle(
                      color: MyColors.c_686868,
                      fontSize: MyFontSizes.s_12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: MySizes.s_6),
                    child: Text(
                      "${data.lookRecord}${GmLocalizations.of(context).consultationBrowseNumTitle}",
                      style: TextStyle(
                        color: MyColors.c_929292,
                        fontSize: MyFontSizes.s_10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image(
            image: MyImages.ic_mine_arrow,
          ),
        ],
      ),
    );
  }
}
