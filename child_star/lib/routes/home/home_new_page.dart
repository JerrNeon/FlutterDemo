import 'dart:core';

import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/net/net_config.dart';
import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/widgets/banner_widget.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/search_widget.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeNewPage extends StatefulWidget {
  @override
  _HomeNewPageState createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage>
    with AutomaticKeepAliveClientMixin {
  final _refreshController = RefreshController();
  Future _future;
  List<News> _news;
  var pageIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _initFuture();
    super.initState();
  }

  _initFuture() {
    var netManager = NetManager(context);
    _future = Future.wait([
      netManager.getHotTagList(),
      netManager.getBannerList(),
      netManager.getNewsList(pageIndex = PAGE_INDEX),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: MyColors.c_f0f0f0,
        child: Column(
          children: <Widget>[
            SearchWidget(),
            Expanded(
                child: FutureBuilderWidget<List>(
                    future: _future,
                    onErrorRetryTap: () {
                      _initFuture();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    builder: (context, snapshot) {
                      List list = snapshot.data;
                      if (list != null && list.isNotEmpty && list.length == 3) {
                        List<Tag> tags = list[0];
                        List<Banners> banners = list[1] ?? [];
                        PageList<News> pageList = list[2];
                        _news = pageList?.resultList ?? [];
                        return Column(
                          children: <Widget>[
                            _buildTag(tags),
                            Expanded(child: _buildBody(banners)),
                          ],
                        );
                      }
                      return EmptyWidget();
                    })),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(List<Tag> tagList) {
    return Container(
      height: MySizes.s_48,
      margin: EdgeInsets.only(
          top: MySizes.s_6, bottom: MySizes.s_6, right: MySizes.s_6),
      padding:
          EdgeInsets.symmetric(horizontal: MySizes.s_8, vertical: MySizes.s_8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(MySizes.s_40),
          bottomRight: Radius.circular(MySizes.s_40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: MyImages.icon_home_tag,
            width: MySizes.s_25,
            height: MySizes.s_20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: MySizes.s_4),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: MySizes.s_6,
                  right: MySizes.s_6,
                ),
                itemBuilder: (context, index) {
                  return _buildTagItem(
                      tagList != null ? tagList[index].id.toString() : "",
                      tagList != null ? tagList[index].name : "");
                },
                itemCount: tagList != null
                    ? tagList.length > 3 ? 3 : tagList.length
                    : 0,
              ),
            ),
          ),
          GestureDetector(
            child: Image(
              image: MyImages.icon_home_tagall,
              width: MySizes.s_30,
              height: MySizes.s_30,
            ),
            onTap: () => RoutersNavigate().navigateToHomeTagListPage(context),
          )
        ],
      ),
    );
  }

  Widget _buildTagItem(String id, String text) {
    return GestureDetector(
      onTap: () =>
          RoutersNavigate().navigateToHomeSearchResultPage(context, id, text),
      child: Container(
        margin: EdgeInsets.only(right: MySizes.s_4),
        padding: EdgeInsets.symmetric(
            horizontal: MySizes.s_8, vertical: MySizes.s_2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MySizes.s_10),
            border: Border.all(
              color: MyColors.c_c0c0c0,
              width: MySizes.s_1,
            )),
        child: Text(
          text,
          style: TextStyle(color: MyColors.c_a7a7a7, fontSize: MySizes.s_12),
        ),
      ),
    );
  }

  Widget _buildBody(List<Banners> list) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      onRefresh: () => _onRefresh(),
      onLoading: () => _onLoad(),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildBanner(list),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: MySizes.s_5,
              top: MySizes.s_5,
              right: MySizes.s_5,
            ),
            sliver: SliverStaggeredGrid.countBuilder(
              crossAxisCount: 2,
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return HomeNewsItemWidget(data: _news[index]);
              },
              itemCount: _news?.length ?? 0,
              mainAxisSpacing: MySizes.s_5,
              crossAxisSpacing: MySizes.s_5,
            ),
          ),
        ],
      ),
    );
  }

  _onRefresh() async {
    try {
      PageList<News> newsList =
          await NetManager(context).getNewsList(pageIndex = PAGE_INDEX);
      _news?.clear();
      _news?.addAll(newsList.resultList);
      if (mounted) {
        setState(() {});
      }
      _refreshController.refreshCompleted(resetFooterState: true);
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  _onLoad() async {
    try {
      PageList<News> newsList =
          await NetManager(context).getNewsList(++pageIndex);
      var list = newsList.resultList;
      if (list != null && list.isNotEmpty) {
        _news.addAll(list);
        if (mounted) {
          setState(() {});
        }
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    } catch (e) {
      _refreshController.loadFailed();
      pageIndex--;
    }
  }

  Widget _buildBanner(List<Banners> list) {
    return Padding(
      padding: EdgeInsets.only(
        left: MySizes.s_4,
        right: MySizes.s_4,
      ),
      child: BannerWidget(list),
    );
  }
}
