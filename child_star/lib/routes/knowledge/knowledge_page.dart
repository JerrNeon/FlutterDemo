import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
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
            SearchWidget(),
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
        return GestureDetector(
          onTap: () => RoutersNavigate()
              .navigateToLectureDetail(context, data.id.toString()),
          child: _buildItem(data),
        );
      }, childCount: list?.length ?? 0),
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
