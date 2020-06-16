import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:xmly/xmly_index.dart';

class XmlyAlbumDetailPage extends StatefulWidget {
  final int albumId;

  const XmlyAlbumDetailPage({Key key, @required this.albumId})
      : super(key: key);
  @override
  _XmlyAlbumDetailPageState createState() => _XmlyAlbumDetailPageState(albumId);
}

class _XmlyAlbumDetailPageState extends State<XmlyAlbumDetailPage> {
  final int albumId;
  final _solidController = SolidController();
  final _globalKey = GlobalKey<SmartRefresherWidgetState>();
  Future<AlbumPageList> _albumFuture;
  IPlayStatusCallback _iPlayStatusCallback;
  bool _isAsc = true;
  int _currPlayTrackId;
  int _totalPage = 0;
  int _totalCount = 0;
  bool _isShowBottomSheet = true; //是否显示BottomSheet

  _XmlyAlbumDetailPageState(this.albumId);

  @override
  void initState() {
    StatusBarUtils.setTransparent();
    _initAlbumFuture();
    _initStatus();
    _initListener();
    super.initState();
  }

  @override
  void deactivate() {
    StatusBarUtils.setDark();
    super.deactivate();
  }

  @override
  void dispose() {
    if (_iPlayStatusCallback != null)
      Xmly().removePlayerStatusListener(_iPlayStatusCallback);
    if (_solidController != null) _solidController.dispose();
    super.dispose();
  }

  ///获取专辑详情
  _initAlbumFuture() {
    _albumFuture = XmlyNetManager().getSearchAlbumList(id: albumId);
  }

  ///初始化播放状态
  _initStatus() async {
    Track track = await Xmly().getCurrSound();
    if (track != null) {
      _currPlayTrackId = track.id;
      if (_globalKey.currentState.mounted) {
        _globalKey.currentState.setState(() {});
      }
    }
  }

  ///获取专辑下的声音列表
  Future<PageList<Track>> _initTrackFuture(int pageIndex) async {
    TrackPageList trackPageList = await XmlyNetManager().getTracks(
      albumId: albumId,
      sort: _isAsc ? XmlyData.ASC : XmlyData.DESC,
      page: pageIndex,
    );
    PageList<Track> pageList = PageList();
    if (trackPageList != null) {
      pageList.pageNum = trackPageList.currentPage;
      pageList.totalNum = trackPageList.totalCount;
      pageList.resultList = trackPageList.tracks;
      _totalPage = trackPageList.totalPage;
      _totalCount = trackPageList.totalCount;
    }
    return pageList;
  }

  ///初始化播放状态回调
  _initListener() async {
    _iPlayStatusCallback ??= IPlayStatusCallback();
    _iPlayStatusCallback.onPlayStart = () async {
      Track track = await Xmly().getCurrSound();
      if (track != null) {}
      LogUtils.d("xmly album detail -> onPlayStart");
    };
    _iPlayStatusCallback.onPlayPause = () async {
      Track track = await Xmly().getCurrSound();
      if (track != null) {}
      LogUtils.d("xmly album detail -> onPlayPause");
    };
    _iPlayStatusCallback.onSoundPrepared = () async {
      _initStatus();
      LogUtils.d("xmly album detail -> onSoundPrepared");
    };
    Xmly().addPlayerStatusListener(_iPlayStatusCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      backgroundColor: MyColors.c_6a8994,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTop(),
            SizedBox(height: MySizes.s_8),
            _buildContent(),
          ],
        ),
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MySizes.s_16,
              vertical: MySizes.s_12,
            ),
            child: Image(image: MyImages.ic_login_back),
          ),
        ),
        XmlyAlbumDetailCollectionWidget(albumId: albumId),
      ],
    );
  }

  Widget _buildContent() {
    GmLocalizations gm = GmLocalizations.of(context);
    return FutureBuilderWidget<AlbumPageList>(
      future: _albumFuture,
      builder: (context, snapshot) {
        AlbumPageList pageList = snapshot.data;
        Album data = pageList.albums[0];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                SizedBox(width: MySizes.s_16),
                Stack(
                  children: <Widget>[
                    loadImage(
                      data.coverUrlMiddle,
                      width: MySizes.s_104,
                      height: MySizes.s_104,
                    ),
                    Positioned(
                      left: 0,
                      top: 8,
                      child: Image(image: MyImages.ic_xmly_logo),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: XmlyPlayCountWidget(playCount: data.playCount),
                    ),
                  ],
                ),
                SizedBox(width: MySizes.s_30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      data.isFinished == 2
                          ? Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MySizes.s_4,
                                    vertical: MySizes.s_1,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: MySizes.s_1,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(MySizes.s_3),
                                  ),
                                  child: Text(
                                    gm.xmlyIsFinishedText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                SizedBox(width: MySizes.s_8),
                                Expanded(
                                  child: Text(
                                    data.albumTitle,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MyFontSizes.s_15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              data.albumTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MyFontSizes.s_15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      SizedBox(height: MySizes.s_12),
                      Text(
                        gm.xmlySourceTitle,
                        style: TextStyle(
                          color: MyColors.c_e2e2e2,
                          fontSize: MyFontSizes.s_11,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: MySizes.s_16),
              ],
            ),
            SizedBox(height: MySizes.s_26),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.s_16),
              child: Text(
                data.albumIntro,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MyFontSizes.s_15,
                  letterSpacing: MySizes.s_10,
                ),
              ),
            ),
            SizedBox(height: MySizes.s_42),
          ],
        );
      },
    );
  }

  Widget _buildBottomSheet() {
    return SolidBottomSheet(
      controller: _solidController,
      draggableBody: true,
      showOnAppear: _isShowBottomSheet,
      onShow: () => _isShowBottomSheet = true,
      onHide: () => _isShowBottomSheet = false,
      headerBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MySizes.s_10),
            topRight: Radius.circular(MySizes.s_10),
          ),
        ),
        child: Column(children: <Widget>[
          SizedBox(height: MySizes.s_4),
          Container(
            width: MySizes.s_36,
            height: MySizes.s_4,
            decoration: BoxDecoration(
              color: MyColors.c_d5d5d5,
              borderRadius: BorderRadius.circular(MySizes.s_2),
            ),
          ),
          SizedBox(height: MySizes.s_34),
          DividerWidget(
            width: double.infinity,
            color: MyColors.c_f4f4f4,
          ),
        ]),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverPersistentHeaderDelegate(
              minHeight: MySizes.s_54,
              maxHeight: MySizes.s_54,
              child: XmlyAlbumDetailTrackTopWidget(
                albumId: albumId,
                onTapPlayAll: (playStatus) => _playAll(playStatus),
                onSortChanged: (isAsc) => _doSort(isAsc),
              ),
            ),
          ),
          SliverFillRemaining(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SmartRefresherWidget<Track>.list(
      key: _globalKey,
      onRefreshLoading: (pageIndex) => _initTrackFuture(pageIndex),
      keepAlive: true,
      listItemBuilder: (context, index, data) => GestureDetector(
        onTap: () => _play(index),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: data.id == _currPlayTrackId,
                      child: XmlyPlayAnimationWidget(),
                      replacement: Text(
                        _isAsc
                            ? "${data.orderNum + 1}"
                            : "${_totalCount - data.orderNum}",
                        style: TextStyle(
                          color: MyColors.c_919191,
                          fontSize: MyFontSizes.s_15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.trackTitle,
                          style: TextStyle(
                            color: data.id == _currPlayTrackId
                                ? MyColors.c_ffa2b1
                                : MyColors.c_585858,
                            fontSize: MyFontSizes.s_15,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image(image: MyImages.ic_xmly_album_playnum),
                            SizedBox(width: MySizes.s_4),
                            Text(
                              NumberUtils.getPlayCount(context, data.playCount),
                              style: TextStyle(
                                color: MyColors.c_9e9e9e,
                                fontSize: MyFontSizes.s_11,
                              ),
                            ),
                            SizedBox(width: MySizes.s_16),
                            Image(image: MyImages.ic_xmly_album_time),
                            SizedBox(width: MySizes.s_4),
                            Text(
                              TimeUtils.formatDateS(data.duration),
                              style: TextStyle(
                                color: MyColors.c_9e9e9e,
                                fontSize: MyFontSizes.s_11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MySizes.s_10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        TimeUtils.getTimeFromMilliSeconds(data.updatedAt),
                        style: TextStyle(
                          color: MyColors.c_9e9e9e,
                          fontSize: MyFontSizes.s_11,
                        ),
                      ),
                      SizedBox(height: MySizes.s_10),
                      Image(image: MyImages.ic_xmly_album_play),
                    ],
                  ),
                  SizedBox(width: MySizes.s_14),
                ],
              ),
              SizedBox(height: 12),
              Divider(
                height: 1,
                indent: 60,
                color: Color(0xfff4f4f4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _doSort(bool isAsc) {
    _isAsc = isAsc;
    _globalKey.currentState.initFuture();
    _globalKey.currentState.pullDownOnRefresh();
  }

  _playAll(int playStatus) {
    if (playStatus == 1) {
      Xmly().pause();
    } else if (playStatus == 2) {
      Xmly().play();
    } else {
      _play(0, isNavigateToXmlyPlayPage: false);
    }
  }

  _play(int index, {bool isNavigateToXmlyPlayPage = true}) {
    List<Track> tracks = _globalKey.currentState.data;
    int prePage = 1;
    int pageIndex = _globalKey.currentState.pageIndex;
    XmlyUtils.playList(
      context,
      list: tracks,
      playIndex: index,
      albumId: albumId,
      totalPage: _totalPage,
      totalSize: _totalCount,
      prePage: prePage,
      page: pageIndex,
      isNavigateToXmlyPlayPage: isNavigateToXmlyPlayPage,
    );
  }
}
