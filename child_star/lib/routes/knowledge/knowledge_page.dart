import 'package:child_star/common/net/net_config.dart';
import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/pagelist.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Banners>> _bannerFuture;
  Future<PageList<Lecture>> _listFuture;
  RefreshController _refreshController = RefreshController();
  List<Lecture> _lectureList;
  var _pageIndex = PAGE_INDEX;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  _initFuture() {
    NetManager netManager = NetManager(context);
    _bannerFuture = netManager.getBannerList(id: 2);
    _listFuture = netManager.getLectureList(pageIndex: _pageIndex);
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
            SearchWidget(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: FutureBuilderWidget(
        future: _listFuture,
        builder:
            (BuildContext context, AsyncSnapshot<PageList<Lecture>> snapshot) {
          _lectureList = snapshot.data.resultList;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () => _onRefresh(),
              onLoading: () => _onLoad(),
              child: CustomScrollView(
                slivers: <Widget>[
                  _buildBanner(),
                  _buildList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onRefresh() async {
    try {
      _pageIndex = PAGE_INDEX;
      PageList<Lecture> pageList =
          await NetManager(context).getLectureList(pageIndex: _pageIndex);
      _lectureList?.clear();
      _lectureList?.addAll(pageList.resultList);
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
      PageList<Lecture> pageList =
          await NetManager(context).getLectureList(pageIndex: ++_pageIndex);
      var list = pageList.resultList;
      if (list != null && list.isNotEmpty) {
        _lectureList?.addAll(list);
        if (mounted) {
          setState(() {});
        }
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    } catch (e) {
      _refreshController.loadFailed();
      _pageIndex--;
    }
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

  Widget _buildList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _buildItem(_lectureList[index]);
      }, childCount: _lectureList?.length ?? 0),
    );
  }

  Widget _buildItem(Lecture data) {
    return Container(
      color: Colors.white,
      height: MySizes.s_88,
      margin: EdgeInsets.only(bottom: MySizes.s_4),
      child: Row(
        children: <Widget>[
          loadImage(
            data.headUrl,
            width: MySizes.s_144,
            height: double.infinity,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(MySizes.s_4),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: MySizes.s_5,
                    right: MySizes.s_5,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Offstage(
                      offstage: !data.isNew,
                      child: Image(
                        image: MyImages.ic_lecture_new,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: MySizes.s_12,
                    right: MySizes.s_5,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: MySizes.s_6,
                          ),
                          child: Text(
                            data.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.c_686868,
                              fontSize: MyFontSizes.s_12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          data.descr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.c_686868,
                            fontSize: MyFontSizes.s_12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: MySizes.s_8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: MyColors.c_efefef,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(MySizes.s_14),
                          bottomLeft: Radius.circular(MySizes.s_14),
                        ),
                      ),
                      child: _buildPrice(data),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPrice(Lecture data) {
    if (data.price != 0) {
      return Padding(
        padding: EdgeInsets.only(
          left: MySizes.s_8,
          top: MySizes.s_2,
          right: MySizes.s_3,
          bottom: MySizes.s_2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: MySizes.s_6),
              child: Text(
                "${data.price}",
                style: TextStyle(
                  color: MyColors.c_7c7c7c,
                  fontSize: MyFontSizes.s_12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image(
              image: MyImages.ic_mine_point,
              width: MySizes.s_11,
              height: MySizes.s_11,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_8,
          vertical: MySizes.s_2,
        ),
        child: Text(
          "VIP",
          style: TextStyle(
            color: MyColors.c_7c7c7c,
            fontSize: MyFontSizes.s_12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
