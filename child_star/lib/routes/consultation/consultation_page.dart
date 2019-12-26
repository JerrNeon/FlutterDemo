import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/widgets/page/page_index.dart';
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
                    onTap: () =>
                        RoutersNavigate().navigateToInquiryPage(context),
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
              RoutersNavigate().navigateToWikiTagPage(context);
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
          listItemBuilder: (context, index, data) => WikiItemWidget(data: data),
        ),
        EmptyWidget(),
      ],
    );
  }
}
