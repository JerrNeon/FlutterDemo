import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class XmlyPage extends StatefulWidget {
  @override
  _XmlyPageState createState() => _XmlyPageState();
}

class _XmlyPageState extends State<XmlyPage>
    with AutomaticKeepAliveClientMixin {
  Future _future;
  Future<XmlyBannersPageList> _bannersFuture;
  Future<ColumnsPageList> _columnListFuture;
  Future<ColumnBatchAlbumPageList> _columnAlbumFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _initFuture();
    super.initState();
  }

  _initFuture() {
    _bannersFuture = XmlyNetManager().getBannerList();
    _columnListFuture = XmlyNetManager().getColumnList();
    _columnAlbumFuture = XmlyNetManager()
        .getColumnBatchAlbumList(ids: XmlyData.COLUMN_IDS, count: 3);
    _future =
        Future.wait([_bannersFuture, _columnListFuture, _columnAlbumFuture]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: MyColors.c_f4f4f4,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchWidget(
            onTap: null,
          ),
          Expanded(
            child: FutureBuilderWidget(
              future: _future,
              onErrorRetryTap: () {
                if (mounted) {
                  _initFuture();
                  setState(() {});
                }
              },
              builder: (context, snapshot) {
                List list = snapshot.data;
                if (list != null && list.isNotEmpty && list.length == 3) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      _buildBanner(list[0]),
                      _buildType(list[1]),
                      _buildList(list[2]),
                    ],
                  );
                } else {
                  return EmptyWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(XmlyBannersPageList list) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
        sliver: SliverToBoxAdapter(
          child: list != null && list.banners != null && list.banners.isNotEmpty
              ? XmlyBannerWidget(
                  list.banners,
                  onTap: (index) {
                    XmlyBanners banner = list.banners[index];
                    if (banner.bannerContentType == 2) {
                      _onTapAlbum(banner.bannerContentId);
                    }
                  },
                )
              : EmptyWidget(),
        ));
  }

  Widget _buildType(ColumnsPageList list) {
    GmLocalizations gm = GmLocalizations.of(context);
    List<Columns> columnList = list?.columns;
    if (columnList == null) {
      columnList = [];
    } else {
      columnList.removeWhere((element) =>
          element.id == XmlyData.COLUMN_HOT_ID ||
          element.id == XmlyData.COLUMN_POP_ID ||
          element.id == XmlyType.RECENT ||
          element.id == XmlyType.COLLECT);
    }
    columnList
      ..add(Columns(id: XmlyType.RECENT))
      ..add(Columns(id: XmlyType.COLLECT));
    return SliverPadding(
      padding: EdgeInsets.only(top: 16, bottom: 26),
      sliver: SliverGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: MySizes.s_20,
        childAspectRatio: 1.4,
        children: columnList
            .map((e) => GestureDetector(
                  onTap: () => _onTapColumn(e.id),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (e.id == XmlyType.RECENT || e.id == XmlyType.COLLECT)
                          ? Image(
                              image: e.id == XmlyType.RECENT
                                  ? MyImages.ic_xmly_recent
                                  : MyImages.ic_xmly_collect)
                          : loadImage(
                              e.coverUrlSmall,
                              width: 42,
                              height: 42,
                            ),
                      SizedBox(height: 6),
                      Text(
                        e.id == XmlyType.RECENT
                            ? gm.xmlyRecentTitle
                            : e.id == XmlyType.COLLECT
                                ? gm.xmlyCollectTitle
                                : e.title,
                        style: TextStyle(
                          color: MyColors.c_686868,
                          fontSize: MyFontSizes.s_14,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildList(ColumnBatchAlbumPageList list) {
    if (list != null && list.columns != null && list.columns.isNotEmpty) {
      List<Columns> columnsList = list.columns;
      List<Future<ColumnsAlbumPageList>> futureList = list.albumFutures;
      GmLocalizations gm = GmLocalizations.of(context);
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Columns data = columnsList[index];
            return Container(
              margin: EdgeInsets.only(
                left: MySizes.s_4,
                right: MySizes.s_4,
                bottom: MySizes.s_6,
              ),
              padding: EdgeInsets.only(
                left: MySizes.s_14,
                top: MySizes.s_14,
                bottom: MySizes.s_14,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(MySizes.s_3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data.title,
                        style: TextStyle(
                          color: MyColors.c_686868,
                          fontSize: MyFontSizes.s_14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _onTapColumn(data.id),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: MySizes.s_10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                gm.xmlyMoreTitle,
                                style: TextStyle(
                                  color: MyColors.c_686868,
                                  fontSize: MyFontSizes.s_12,
                                ),
                              ),
                              SizedBox(width: 6),
                              Image(image: MyImages.ic_mine_arrow),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildAlbumList(index, futureList),
                ],
              ),
            );
          },
          childCount: columnsList.length,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: EmptyWidget(),
      );
    }
  }

  Widget _buildAlbumList(int index, List<Future<ColumnsAlbumPageList>> list) {
    GmLocalizations gm = GmLocalizations.of(context);
    return EmptyFutureBuilderWidget(
        future: list[index],
        builder: (context, snapshot) {
          ColumnsAlbumPageList pageList = snapshot.data;
          if (pageList != null &&
              pageList.values != null &&
              pageList.values.isNotEmpty) {
            List<Album> albumList = pageList.values;
            return GridView.builder(
              padding: EdgeInsets.only(right: MySizes.s_14),
              shrinkWrap: true,
              itemCount: albumList?.length ?? 0,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: MySizes.s_14,
                childAspectRatio: 104.0 / 152.0,
              ),
              itemBuilder: (context, index) {
                Album data = albumList[index];
                return GestureDetector(
                  onTap: () => _onTapAlbum(data.id),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          loadImage(
                            data.coverUrlMiddle,
                            width: 104,
                            height: 104,
                          ),
                          Positioned(
                            left: 0,
                            top: 8,
                            child: Image(image: MyImages.ic_xmly_logo),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child:
                                XmlyPlayCountWidget(playCount: data.playCount),
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      data.isFinished == 2
                          ? Text.rich(
                              TextSpan(children: [
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MySizes.s_6,
                                      vertical: MySizes.s_1,
                                    ),
                                    margin: EdgeInsets.only(right: MySizes.s_4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.c_ff93a4,
                                        width: MySizes.s_1,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(MySizes.s_3),
                                    ),
                                    child: Text(
                                      gm.xmlyIsFinishedText,
                                      style: TextStyle(
                                        color: MyColors.c_ff93a4,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: data.albumTitle,
                                  style: TextStyle(
                                    color: MyColors.c_686868,
                                    fontSize: MyFontSizes.s_14,
                                  ),
                                ),
                              ]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              data.albumTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: MyColors.c_686868,
                                fontSize: MyFontSizes.s_14,
                              ),
                            ),
                    ],
                  ),
                );
              },
            );
          } else {
            return EmptyWidget();
          }
        });
  }

  ///点击听单分类
  _onTapColumn(int columnId) {}

  ///点击专辑
  _onTapAlbum(int albumId) {}
}
