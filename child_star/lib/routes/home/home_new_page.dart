import 'dart:core';
import 'dart:math';

import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/net/net_config.dart';
import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/image_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/banner_widget.dart';
import 'package:child_star/widgets/empty_widget.dart';
import 'package:child_star/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeNewPage extends StatefulWidget {
  @override
  _HomeNewPageState createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();

  Future<List<Tag>> _tagList;
  Future<List<Banners>> _bannersList;
  Future<Newslist> _newsList;
  List<News> _news;
  var pageIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    var netManager = NetManager(context);
    _tagList = netManager.getHotTagList();
    _bannersList = netManager.getBannerList();
    _newsList = netManager.getNewsList(pageIndex = PAGE_INDEX);
    super.initState();
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
            _buildTag(),
            _buildBody(_refreshController),
          ],
        ),
      ),
    );
  }

  Widget _buildTag() {
    return FutureBuilder(
        future: _tagList,
        builder: (context, AsyncSnapshot<List<Tag>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              LogUtils.e(snapshot.error.toString());
              return EmptyWidget();
            } else {
              List<Tag> tagList = snapshot.data;
              return Container(
                height: MySizes.s_44,
                margin: EdgeInsets.only(
                    top: MySizes.s_6, bottom: MySizes.s_6, right: MySizes.s_6),
                padding: EdgeInsets.symmetric(
                    horizontal: MySizes.s_8, vertical: MySizes.s_8),
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
                      onTap: () {},
                    )
                  ],
                ),
              );
            }
          } else {
            return EmptyWidget();
          }
        });
  }

  Widget _buildTagItem(String text) {
    return GestureDetector(
      onTap: () {},
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

  Widget _buildBody(RefreshController refreshController) {
    return Expanded(
      child: FutureBuilder(
        future: _newsList,
        builder: (context, AsyncSnapshot<Newslist> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              LogUtils.e(snapshot.error.toString());
              return EmptyWidget();
            } else {
              _news = snapshot.data.resultList;
              return SmartRefresher(
                controller: _refreshController,
                header: ClassicHeader(),
                footer: ClassicFooter(),
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: () => _onRefresh(),
                onLoading: () => _onLoad(),
                child: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _buildBanner(),
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
                        return _buildBodyItem(_news[index]);
                      },
                      itemCount: _news?.length ?? 0,
                      mainAxisSpacing: MySizes.s_5,
                      crossAxisSpacing: MySizes.s_5,
                    ),
                  ),
                ]),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _onRefresh() async {
    try {
      Newslist newsList = await NetManager(context).getNewsList(pageIndex = 1);
      _news?.clear();
      _news..addAll(newsList.resultList);
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
      Newslist newsList = await NetManager(context).getNewsList(++pageIndex);
      var resultList = newsList.resultList;
      if (resultList != null) {
        _news.addAll(resultList);
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

  Widget _buildBanner() {
    return FutureBuilder(
        future: _bannersList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              LogUtils.e(snapshot.error.toString());
              return EmptyWidget();
            } else {
              return Padding(
                padding: EdgeInsets.only(
                  left: MySizes.s_4,
                  right: MySizes.s_4,
                ),
                child: BannerWidget(snapshot.data),
              );
            }
          } else {
            return EmptyWidget();
          }
        });
  }

  Widget _buildBodyItem(News news) {
    return GestureDetector(
      onTap: () =>
          RoutersNavigate().navigateToNewDetail(context, news.id.toString()),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MySizes.s_4, MySizes.s_4, MySizes.s_4, MySizes.s_6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MySizes.s_3),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                cachedNetworkImage(news.headUrl, borderRadius: MySizes.s_3),
                Container(
                    padding: EdgeInsets.all(MySizes.s_5),
                    child: (news.type == 1 || news.type == 2)
                        ? Image(image: MyImagesMultiple.home_media[news.type])
                        : EmptyWidget()),
                Positioned(
                  right: MySizes.s_5,
                  bottom: MySizes.s_5,
                  child: Container(
                    padding: EdgeInsets.all(MySizes.s_5),
                    decoration: BoxDecoration(
                      color: MyColorsFul.home_tag[Random().nextInt(6)],
                      borderRadius: BorderRadius.circular(MySizes.s_11),
                      border: Border.all(
                        color: Colors.white,
                        width: MySizes.s_1,
                      ),
                    ),
                    child: Text(
                      news.innerWord,
                      style: TextStyle(
                          color: Colors.white, fontSize: MyFontSizes.s_12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: MySizes.s_7),
              child: Text(
                news.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: MyColors.c_686868, fontSize: MyFontSizes.s_12),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: MySizes.s_30),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MySizes.s_6),
                        child: Image(image: MyImages.ic_homenew_look),
                      ),
                      Text(
                        news.lookRecord.toString(),
                        style: TextStyle(
                            color: MyColors.c_7f7f7f,
                            fontSize: MyFontSizes.s_14),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: MySizes.s_6),
                        color: MyColors.c_7f7f7f,
                        width: MySizes.s_1,
                        height: MySizes.s_12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MySizes.s_6),
                        child: Image(
                            image:
                                MyImagesMultiple.home_collection[news.isLike]),
                      ),
                      Text(
                        news.like.toString(),
                        style: TextStyle(
                            color: MyColors.c_7f7f7f,
                            fontSize: MyFontSizes.s_14),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
