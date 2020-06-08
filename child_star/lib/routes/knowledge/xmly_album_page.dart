import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_index.dart';

class XmlyAlbumPage extends StatefulWidget {
  final int columnId;
  final String title;

  const XmlyAlbumPage({
    Key key,
    @required this.columnId,
    this.title,
  }) : super(key: key);
  @override
  _XmlyAlbumPageState createState() =>
      _XmlyAlbumPageState(columnId, chineseDecode(title));
}

class _XmlyAlbumPageState extends State<XmlyAlbumPage> {
  final int columnId;
  final String title;
  DbUtils _dbUtils;
  List<XmlyResource> _xmlyResourceList;

  _XmlyAlbumPageState(this.columnId, this.title);

  Future<PageList<Album>> _initAlbumFuture({
    @required num pageIndex,
  }) async {
    PageList<Album> pageList = PageList();
    if (columnId == XmlyType.RECENT) {
      if (_dbUtils == null) {
        _dbUtils = DbUtils();
        await _dbUtils.open();
      }
      _xmlyResourceList = await _dbUtils.getXmlyResourceList();
      if (_xmlyResourceList != null && _xmlyResourceList.isNotEmpty) {
        String ids = _xmlyResourceList.join(",");
        List<Album> albumList =
            await XmlyNetManager().getAlbumBatchList(ids: ids);
        pageList.resultList = albumList;
      }
    } else if (columnId == XmlyType.COLLECT) {
      MyCollectionPageList myCollectionPageList = await NetManager(context)
          .getMyCollectionList(pageIndex: pageIndex, type: 3);
      String ids = myCollectionPageList.ids;
      if (ids != null && ids.isNotEmpty) {
        List<Album> albumList =
            await XmlyNetManager().getAlbumBatchList(ids: ids);
        pageList.pageNum = myCollectionPageList.pageNum;
        pageList.totalNum = myCollectionPageList.totalNum;
        pageList.resultList = albumList;
      }
    } else {
      ColumnsAlbumPageList columnsAlbumPageList =
          await XmlyNetManager().getAlbumList(id: columnId, page: pageIndex);
      pageList.pageNum = columnsAlbumPageList.currentPage;
      pageList.totalNum = columnsAlbumPageList.totalCount;
      pageList.resultList = columnsAlbumPageList.values;
    }
    return pageList;
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      backgroundColor: MyColors.c_f0f0f0,
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBarWidget(columnId == XmlyType.RECENT
              ? gm.xmlyAlbumRecentTitle
              : columnId == XmlyType.COLLECT
                  ? gm.xmlyAlbumCollectTitle
                  : title),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SmartRefresherWidget<Album>.listSeparated(
      onRefreshLoading: (pageIndex) => _initAlbumFuture(pageIndex: pageIndex),
      listItemBuilder: (context, index, album) => columnId == XmlyType.RECENT
          ? XmlyAlbumWidget(
              data: album,
              type: XmlyAlbumWidget.TYPE_RECENT,
              orderNum: _xmlyResourceList[index].trackOrderNum,
              onTap: () => _onTapRecent(_xmlyResourceList[index]),
            )
          : XmlyAlbumWidget(data: album),
      listSeparatorBuilder: (context, index, album) =>
          SizedBox(height: MySizes.s_12),
      listPadding: EdgeInsets.only(top: MySizes.s_12),
      isShowNoData: true,
      noDataWidget: XmlyAlbumEmptyWidget(),
      enablePullDown: columnId != XmlyType.RECENT,
      enablePullUp: columnId != XmlyType.RECENT,
    );
  }

  _onTapRecent(XmlyResource data) async {
    int orderNum = data.trackOrderNum;
    int pageIndex;
    if (orderNum % XmlyData.PAGE_SIZE != 0) {
      pageIndex = orderNum ~/ XmlyData.PAGE_SIZE + 1;
    } else {
      pageIndex = orderNum ~/ XmlyData.PAGE_SIZE;
    }
    TrackPageList trackPageList = await XmlyNetManager()
        .getTracks(albumId: data.albumId, page: pageIndex);
    List<Track> tracks = trackPageList?.tracks;
    if (tracks != null && tracks.isNotEmpty) {
      XmlyUtils.playList(
        context,
        list: tracks,
        playIndex: 0,
        albumId: data.albumId,
        totalPage: trackPageList.totalPage,
        totalSize: trackPageList.totalCount,
        prePage: pageIndex,
        page: pageIndex,
      );
    }
  }
}
