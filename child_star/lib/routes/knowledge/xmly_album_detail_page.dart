import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
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
  final GlobalKey<SmartRefresherWidgetState> _globalKey = GlobalKey();
  UserProvider _userProvider;
  Future<AlbumPageList> _albumFuture;
  IPlayStatusCallback _iPlayStatusCallback;
  int _playStatus = 0; //0：未在播放 1：正在播放 2：暂停播放
  bool _isCollect = false;
  int _currPlayTrackId;
  bool _isAsc = true;
  int _totalPage = 0;
  int _totalCount = 0;

  _XmlyAlbumDetailPageState(this.albumId);

  @override
  void initState() {
    StatusBarUtils.setTransparent();
    _initStatus();
    _initAlbumFuture();
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
    super.dispose();
  }

  ///初始化收藏状态、播放状态
  _initStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_userProvider.isLogin) {
        Result result = await NetManager()
            .getCollectionStatus(id: albumId.toString(), type: 3);
        _isCollect = result.status == 1;
        Track track = await Xmly().getCurrSound();
        if (track != null) {
          _currPlayTrackId = track.id;
          var album = track.subordinated_album;
          if (album.id == albumId) {
            bool isPlaying = await Xmly().isPlaying();
            _playStatus = isPlaying ? 1 : 2;
          }
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  _initAlbumFuture() {
    _albumFuture = XmlyNetManager().getSearchAlbumList(id: albumId);
  }

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

  _initListener() async {
    _iPlayStatusCallback ??= IPlayStatusCallback();
    _iPlayStatusCallback.onPlayStart = () async {
      Track track = await Xmly().getCurrSound();
      if (track != null) {
        var album = track.subordinated_album;
        if (album.id == albumId) {
          _playStatus = 1;
          if (mounted) {
            setState(() {});
          }
        }
      }
      print("xmly -> onPlayStart");
    };
    _iPlayStatusCallback.onPlayPause = () async {
      Track track = await Xmly().getCurrSound();
      if (track != null) {
        var album = track.subordinated_album;
        if (album.id == albumId) {
          _playStatus = 2;
          if (mounted) {
            setState(() {});
          }
        }
      }
      print("xmly -> onPlayPause");
    };
    _iPlayStatusCallback.onSoundSwitch = () async {
      Track track = await Xmly().getCurrSound();
      if (track != null) {
        _currPlayTrackId = track.id;
        if (mounted) {
          setState(() {});
        }
      }
      print("xmly -> onSoundSwitch");
    };
    Xmly().addPlayerStatusListener(_iPlayStatusCallback);
  }

  @override
  Widget build(BuildContext context) {
    _userProvider ??= Provider.of<UserProvider>(context);
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
        GestureDetector(
          onTap: () => _doCollect(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(MySizes.s_12),
            child: Image(
                image: MyImagesMultiple.xmly_collection_status[_isCollect]),
          ),
        ),
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
          ],
        );
      },
    );
  }

  Widget _buildBottomSheet() {
    GmLocalizations gm = GmLocalizations.of(context);
    return BottomSheet(
        onClosing: () {},
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MySizes.s_10),
            topRight: Radius.circular(MySizes.s_10),
          ),
        ),
        builder: (context) {
          return Column(
            children: <Widget>[
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
              SizedBox(height: MySizes.s_8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _playAll(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(left: MySizes.s_18),
                      padding: EdgeInsets.symmetric(
                        horizontal: MySizes.s_14,
                        vertical: MySizes.s_8,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.c_f4f4f4,
                        borderRadius: BorderRadius.circular(MySizes.s_4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            _playStatus == 1
                                ? gm.xmlyAlbumPauseTitle
                                : _playStatus == 2
                                    ? gm.xmlyAlbumContinueTitle
                                    : gm.xmlyAlbumPlayTitle,
                            style: TextStyle(
                              color: MyColors.c_686868,
                              fontSize: MyFontSizes.s_14,
                            ),
                          ),
                          SizedBox(width: MySizes.s_8),
                          Image(
                              image: _playStatus == 1
                                  ? MyImages.ic_xmly_all_pause
                                  : MyImages.ic_xmly_all_play),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _doSort(),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MySizes.s_16),
                      child: Image(
                          image: _isAsc
                              ? MyImages.ic_xmly_album_asc
                              : MyImages.ic_xmly_album_desc),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MySizes.s_8),
              DividerWidget(
                width: double.infinity,
                color: MyColors.c_f4f4f4,
              ),
              Expanded(
                child: _buildList(),
              ),
            ],
          );
        });
  }

  Widget _buildList() {
    return SmartRefresherWidget<Track>.list(
      key: _globalKey,
      onRefreshLoading: (pageIndex) => _initTrackFuture(pageIndex),
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
                    child: Text(
                      _isAsc
                          ? "${data.orderNum + 1}"
                          : "${_totalCount - data.orderNum}",
                      style: TextStyle(
                        color: MyColors.c_919191,
                        fontSize: MyFontSizes.s_15,
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

  _doCollect() async {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLogin) {
      Result result =
          await NetManager().doCollection(id: albumId.toString(), type: 3);
      if (mounted) {
        _isCollect = result.status == 1;
        setState(() {});
      }
    } else {
      RoutersNavigate().navigateToLogin(context);
    }
  }

  _doSort() {
    _isAsc = !_isAsc;
    _globalKey.currentState.initFuture();
    _globalKey.currentState.pullDownOnRefresh();
    if (mounted) {
      setState(() {});
    }
  }

  _playAll() {
    if (_playStatus == 1) {
      Xmly().pause();
    } else if (_playStatus == 2) {
      Xmly().play();
    } else {
      _play(0);
    }
  }

  _play(int index) {
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
    );
  }
}
