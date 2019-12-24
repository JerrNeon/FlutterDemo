import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Banners>> _bannerFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  _initFuture() {
    _bannerFuture = NetManager(context).getBannerList(id: 2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: MyColors.c_f0f0f0,
        child: Column(
          children: <Widget>[
            SearchWidget(
              onTap: () =>
                  RoutersNavigate().navigateToLectureSearchPage(context),
            ),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
        child: SmartRefresherWidget<Lecture>(
          onRefreshLoading: (pageIndex) =>
              NetManager(context).getLectureList(pageIndex: pageIndex),
          onErrorRetryTap: () => _initFuture(),
          builder: (context, data) {
            return CustomScrollView(
              slivers: <Widget>[
                _buildBanner(),
                _buildList(data),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SliverEmptyFutureBuilderWidget<List<Banners>>(
      future: _bannerFuture,
      builder: (context, snapshot) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: MySizes.s_4),
          sliver: SliverToBoxAdapter(
            child: BannerWidget(snapshot.data),
          ),
        );
      },
    );
  }

  Widget _buildList(List<Lecture> list) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        Lecture data = list[index];
        return LectureItemWidget(data: data);
      }, childCount: list?.length ?? 0),
    );
  }
}
