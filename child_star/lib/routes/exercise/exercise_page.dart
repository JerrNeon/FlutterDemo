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
  Future _future;
  TabController _tabController;

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
    _future = Future.wait([
      netManager.getBannerList(id: 3),
      netManager.getExerciseTagList(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: FutureBuilderWidget<List>(
          future: _future,
          onErrorRetryTap: () {
            _initFuture();
            setState(() {});
          },
          builder: (context, snapshot) {
            List list = snapshot.data;
            if (list != null && list.isNotEmpty && list.length == 2) {
              List<Banners> banners = list[0];
              PageList<ExerciseTag> pageList = list[1];
              List<ExerciseTag> exerciseTags = pageList.resultList;
              ExerciseTag tag = ExerciseTag();
              tag.id = 0;
              tag.name = GmLocalizations.of(context).exerciseAllTitle;
              if (exerciseTags != null && exerciseTags.isNotEmpty) {
                exerciseTags.removeWhere((element) => element.id == 0);
                exerciseTags.insert(0, tag);
              } else {
                exerciseTags = [tag];
              }
              _tabController ??=
                  TabController(length: exerciseTags.length, vsync: this);
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    _buildBanner(banners),
                    _buildTabBar(exerciseTags),
                  ];
                },
                body: _buildTabBarView(exerciseTags),
              );
            }
            return EmptyWidget();
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

  Widget _buildTabBar(List<ExerciseTag> list) {
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
          labelPadding: EdgeInsets.symmetric(
            horizontal: MySizes.s_16,
            vertical: MySizes.s_4,
          ),
          tabs: list.map((e) {
            return Tab(
              text: e.name,
              icon: e.id == 0
                  ? Image(
                      image: MyImages.ic_exercise_taball,
                      width: MySizes.s_34,
                      height: MySizes.s_34,
                    )
                  : loadImage(
                      e.icon,
                      width: MySizes.s_34,
                      height: MySizes.s_34,
                    ),
              iconMargin:
                  EdgeInsets.only(top: MySizes.s_4, bottom: MySizes.s_4),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabBarView(List<ExerciseTag> list) {
    return TabBarView(
      controller: _tabController,
      children: list.map((e) => _buildList(e)).toList(),
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
            height: double.infinity,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
