import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_index.dart';

class XmlyPage extends StatefulWidget {
  @override
  _XmlyPageState createState() => _XmlyPageState();
}

class _XmlyPageState extends State<XmlyPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  Future _future;
  Future<XmlyBannersPageList> _bannersFuture;
  Future<ColumnsPageList> _columnListFuture;
  Future<ColumnBatchAlbumPageList> _columnAlbumFuture;
  IPlayStatusCallback _iPlayStatusCallback;
  DbUtils _dbUtils;
  AnimationController _animationController; //旋转动画
  Animation<double> _turns; //动画值
  XmlyResource _xmlyResource; //本地历史声音
  Track _currTrack; //当前正在播放的声音
  double _playProgress = 0; //播放进度
  bool _isPlayVisible = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _initFuture();
    _initTrack();
    _initAnimation();
    _initListener();
    super.initState();
  }

  @override
  void dispose() {
    if (_iPlayStatusCallback != null)
      Xmly().removePlayerStatusListener(_iPlayStatusCallback, isCancel: true);
    _dbUtils?.close();
    _animationController?.dispose();
    super.dispose();
  }

  _initFuture() {
    _bannersFuture = XmlyNetManager().getBannerList();
    _columnListFuture = XmlyNetManager().getColumnList();
    _columnAlbumFuture = XmlyNetManager()
        .getColumnBatchAlbumList(ids: XmlyData.COLUMN_IDS, count: 3);
    _future =
        Future.wait([_bannersFuture, _columnListFuture, _columnAlbumFuture]);
  }

  _initTrack() async {
    _currTrack = await Xmly().getCurrSound();
    if (_currTrack == null) {
      if (_dbUtils == null) {
        _dbUtils = DbUtils();
        await _dbUtils.open();
      }
      List<XmlyResource> list = await _dbUtils.getXmlyResourceList();
      if (list != null && list.isNotEmpty) {
        _xmlyResource = list[0];
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      bool isPlaying = await Xmly().isPlaying();
      _isPlayVisible = !isPlaying;
      if (isPlaying) {
        _animationController.repeat();
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  _initAnimation() async {
    _animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    _turns = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  ///初始化播放状态回调
  _initListener() {
    _iPlayStatusCallback ??= IPlayStatusCallback();
    _iPlayStatusCallback.onSoundPrepared = () async {
      LogUtils.d("xmly home -> onSoundPrepared");
      //保存当前播放数据到本地
      Track track = _currTrack = await Xmly().getCurrSound();
      if (mounted) {
        _animationController?.reset();
        setState(() {});
      }
      if (track != null && XmlyData.isAsc != null) {
        SubordinatedAlbum album = track.subordinated_album;
        if (album != null) {
          if (_dbUtils == null) {
            _dbUtils = DbUtils();
            await _dbUtils.open();
          }
          bool isExit = await _dbUtils.isXmlyResourceInsert(album.id);
          if (isExit) {
            XmlyResource xmlyResource =
                await _dbUtils.getXmlyResource(album.id);
            if (xmlyResource != null) {
              if (xmlyResource.trackId != track.id) {
                //新的声音
                xmlyResource.trackId = track.id;
                xmlyResource.trackCoverUrl = track.coverUrlMiddle;
                xmlyResource.trackOrderNum = XmlyData.isAsc
                    ? track.orderNum
                    : XmlyData.totalSize - track.orderNum - 1;
              }
              xmlyResource.updateAt = DateTime.now().millisecondsSinceEpoch;
              await _dbUtils.updateXmlyResource(xmlyResource);
            }
          } else {
            //新的专辑
            int nowTimeMillis = DateTime.now().millisecondsSinceEpoch;
            await _dbUtils.insertXmlyResource(XmlyResource(
              albumId: album.id,
              trackId: track.id,
              trackCoverUrl: track.coverUrlMiddle,
              trackOrderNum: XmlyData.isAsc
                  ? track.orderNum
                  : XmlyData.totalSize - track.orderNum - 1,
              createdAt: nowTimeMillis,
              updateAt: nowTimeMillis,
            ));
          }
        }
      }
    };
    _iPlayStatusCallback.onSoundSwitch = () async {
      int currentIndex = await Xmly().getCurrentIndex();
      int playListSize = await Xmly().getPlayListSize();
      if (currentIndex < 2) {
        XmlyUtils.autoLoadPreToPlayList();
      } else if (currentIndex >= playListSize - 2) {
        XmlyUtils.autoLoadNextToPlayList();
      }
    };
    _iPlayStatusCallback.onPlayStart = () {
      _isPlayVisible = false;
      if (mounted) {
        _animationController?.repeat();
        setState(() {});
      }
    };
    _iPlayStatusCallback.onPlayPause = () {
      _isPlayVisible = true;
      if (mounted) {
        _animationController?.stop(canceled: false);
        setState(() {});
      }
    };
    _iPlayStatusCallback.onPlayProgress = (progress) {
      _playProgress = progress;
      if (mounted) {
        setState(() {});
      }
    };
    Xmly().addPlayerStatusListener(_iPlayStatusCallback);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: MyColors.c_f4f4f4,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SearchWidget(
                onTap: () =>
                    RoutersNavigate().navigateToXmlySearchPage(context),
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
          _buildPlay(),
        ],
      ),
    );
  }

  Widget _buildPlay() {
    return _xmlyResource != null || _currTrack != null
        ? Positioned(
            left: 0,
            bottom: MySizes.s_30,
            child: GestureDetector(
              onTap: () => _onTapPlay(),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(
                  left: MySizes.s_18,
                  top: MySizes.s_4,
                  right: MySizes.s_4,
                  bottom: MySizes.s_4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(MySizes.s_60),
                    bottomRight: Radius.circular(MySizes.s_60),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, offset: Offset(2.0, 2.0))
                  ],
                ),
                child: SizedBox(
                  width: MySizes.s_60,
                  height: MySizes.s_60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: 1.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              MyColors.c_7fd4d1d5),
                          strokeWidth: MySizes.s_2,
                        ),
                      ),
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: _playProgress,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(MyColors.c_ffa2b1),
                          strokeWidth: MySizes.s_3,
                        ),
                      ),
                      RotationTransition(
                        turns: _turns,
                        child: loadImage(
                          _currTrack != null
                              ? _currTrack.coverUrlMiddle
                              : _xmlyResource.trackCoverUrl,
                          width: MySizes.s_58,
                          height: MySizes.s_58,
                          loadingWidth: 0,
                          loadingHeight: 0,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Visibility(
                        visible: _isPlayVisible,
                        child: Image(image: MyImages.ic_xmly_home_play),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SizedBox();
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
        children: columnList.asMap().keys.map((e) {
          Columns data = columnList[e];
          return GestureDetector(
            onTap: () => _onTapColumnType(e, data.id),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (data.id == XmlyType.RECENT || data.id == XmlyType.COLLECT)
                    ? Image(
                        image: data.id == XmlyType.RECENT
                            ? MyImages.ic_xmly_recent
                            : MyImages.ic_xmly_collect)
                    : loadImage(
                        data.coverUrlSmall,
                        width: 42,
                        height: 42,
                      ),
                SizedBox(height: 6),
                Text(
                  data.id == XmlyType.RECENT
                      ? gm.xmlyRecentTitle
                      : data.id == XmlyType.COLLECT
                          ? gm.xmlyCollectTitle
                          : data.title,
                  style: TextStyle(
                    color: MyColors.c_686868,
                    fontSize: MyFontSizes.s_14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
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
                        onTap: () => _onTapColumn(data),
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
                                      horizontal: MySizes.s_4,
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
  _onTapColumnType(int index, int columnId) {
    GmLocalizations gm = GmLocalizations.of(context);
    if (columnId == XmlyType.RECENT) {
      RoutersNavigate()
          .navigateToXmlyAlbumPage(context, columnId, gm.xmlyAlbumRecentTitle);
    } else if (columnId == XmlyType.COLLECT) {
      RoutersNavigate()
          .navigateToXmlyAlbumPage(context, columnId, gm.xmlyAlbumCollectTitle);
    } else {
      RoutersNavigate().navigateToXmlyTypePage(context, index);
    }
  }

  ///点击听单
  _onTapColumn(Columns data) {
    RoutersNavigate().navigateToXmlyAlbumPage(context, data.id, data.title);
  }

  ///点击专辑
  _onTapAlbum(int albumId) {
    RoutersNavigate().navigateToXmlyAlbumDetailPage(context, albumId);
  }

  ///点击正在播放的声音
  _onTapPlay() async {
    if (_currTrack != null) {
      bool isPlaying = await Xmly().isPlaying();
      if (!isPlaying) {
        await Xmly().play();
      }
      RoutersNavigate().navigateToXmlyPlayPage(context);
    } else if (_xmlyResource != null) {
      int orderNum = _xmlyResource.trackOrderNum;
      int pageIndex;
      if (orderNum % XmlyData.PAGE_SIZE != 0) {
        pageIndex = orderNum ~/ XmlyData.PAGE_SIZE + 1;
      } else {
        pageIndex = orderNum ~/ XmlyData.PAGE_SIZE;
      }
      TrackPageList trackPageList = await XmlyNetManager()
          .getTracks(albumId: _xmlyResource.albumId, page: pageIndex);
      List<Track> tracks = trackPageList?.tracks;
      if (tracks != null && tracks.isNotEmpty) {
        XmlyUtils.playList(
          context,
          list: tracks,
          playIndex: 0,
          albumId: _xmlyResource.albumId,
          totalPage: trackPageList.totalPage,
          totalSize: trackPageList.totalCount,
          prePage: pageIndex,
          page: pageIndex,
        );
      }
    }
  }
}
