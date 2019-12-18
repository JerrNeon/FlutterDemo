import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/pagelist.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/future_widget.dart';
import 'package:child_star/widgets/sliver_widget.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  Future<List<Banners>> _bannerFuture;
  Future<PageList<ExerciseTag>> _exerciseTagFuture;
  TabController _tabController;
  List<ExerciseTag> _exerciseTagList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  void _initFuture() {
    NetManager netManager = NetManager(context);
    _bannerFuture = netManager.getBannerList(id: 3);
    _exerciseTagFuture = netManager.getExerciseTagList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: FutureBuilderWidget<PageList<ExerciseTag>>(
          future: _exerciseTagFuture,
          onErrorRetryTap: () {
            _initFuture();
            setState(() {});
          },
          builder: (context, snapshot) {
            _exerciseTagList.clear();
            _exerciseTagList.addAll(snapshot.data.resultList);
            ExerciseTag tag = ExerciseTag();
            tag.id = 0;
            tag.name = GmLocalizations.of(context).exerciseAllTitle;
            _exerciseTagList?.insert(0, tag);
            _tabController ??=
                TabController(length: _exerciseTagList.length, vsync: this);
            return EmptyFutureBuilderWidget<List<Banners>>(
                future: _bannerFuture,
                builder: (context, snapshot) {
                  return NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        _buildBanner(snapshot.data),
                        _buildTabBar(),
                      ];
                    },
                    body: _buildTabBarView(),
                  );
                });
          },
        ),
      ),
    );
  }

  Widget _buildBanner(List<Banners> list) {
    return SliverPersistentHeader(
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: 0,
        maxHeight: MySizes.s_153,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MySizes.s_4),
          child: BannerWidget(list),
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
          isScrollable: true,
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
          tabs: _exerciseTagList.map((e) {
            return Tab(text: e.name);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: _exerciseTagList.map((e) => _buildList(e)).toList(),
    );
  }

  Widget _buildList(ExerciseTag tag) {
    return SmartRefresherWidget<Exercise>.list(
      onRefreshLoading: (pageIndex) => NetManager(context)
          .getExerciseList(tagId: tag.id, pageIndex: pageIndex),
      keepAlive: true,
      listItemBuilder: (context, index, data) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => RoutersNavigate()
              .navigateToExerciseDetail(context, data.id.toString()),
          child: _buildItem(data),
        );
      },
    );
  }

  Widget _buildItem(Exercise data) {
    return Container(
      height: MySizes.s_98,
      margin: EdgeInsets.only(
        left: MySizes.s_4,
        top: MySizes.s_4,
        right: MySizes.s_10,
        bottom: MySizes.s_4,
      ),
      child: Row(
        children: <Widget>[
          loadImage(
            data.headUrl,
            width: MySizes.s_144,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(MySizes.s_4),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: MySizes.s_12,
                    right: MySizes.s_8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.c_686868,
                          fontSize: MyFontSizes.s_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: MySizes.s_6),
                        child: Text(
                          data.descr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MyColors.c_686868,
                            fontSize: MyFontSizes.s_12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MySizes.s_4,
                  right: 0,
                  child: Text(
                    data.tagWord,
                    style: TextStyle(
                      color: data.tagWordColor.hexStrToInt().hexColor(),
                      fontSize: MyFontSizes.s_12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
