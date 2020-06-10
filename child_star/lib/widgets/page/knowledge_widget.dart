import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/date_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xmly/xmly_index.dart';

class LectureItemWidget extends StatelessWidget {
  final Lecture data;
  final GestureTapCallback onTap;

  const LectureItemWidget({Key key, this.data, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => RoutersNavigate()
              .navigateToLectureDetail(context, data.id.toString()),
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: MySizes.s_4),
        child: Row(
          children: <Widget>[
            loadImage(
              data.headUrl,
              width: MySizes.s_144,
              height: MySizes.s_88,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(MySizes.s_4),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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

class CourseItemWidget extends StatelessWidget {
  final Course data;
  final int partNum;
  final GestureTapCallback onTap;

  const CourseItemWidget(
    this.data,
    this.partNum, {
    Key key,
    this.onTap,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.isLock) {
          showToast(GmLocalizations.of(context).lectureBuyToast);
          return;
        }
        if (onTap != null) {
          onTap();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_12,
          vertical: MySizes.s_14,
        ),
        child: Row(
          children: <Widget>[
            _buildPartWidget(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MySizes.s_10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    PaddingWidget(
                      top: MySizes.s_6,
                      child: Row(
                        children: <Widget>[
                          Image(image: MyImages.ic_course_time),
                          Text(
                            TimeUtils.formatDateS(data.mediaTime),
                            style: TextStyle(
                              color: MyColors.c_b1b1b1,
                              fontSize: MyFontSizes.s_8,
                            ),
                          ),
                          PaddingWidget(
                            left: MySizes.s_4,
                            child: Image(image: MyImages.ic_course_playnum),
                          ),
                          Text(
                            data.watch.toString(),
                            style: TextStyle(
                              color: MyColors.c_b1b1b1,
                              fontSize: MyFontSizes.s_8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image(
              image: MyImagesMultiple.course_status[data.isLock],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartWidget() {
    if (partNum > 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            data.sNo < 10 ? "C0${data.sNo}" : "C${data.sNo}",
            style: TextStyle(
              color: MyColors.c_f99fae,
              fontSize: MyFontSizes.s_10,
            ),
          ),
          DividerWidget(color: MyColors.c_f99fae, width: MySizes.s_18),
          Text(
            "Part${data.partNo}",
            style: TextStyle(
              color: MyColors.c_f99fae,
              fontSize: MyFontSizes.s_8,
            ),
          ),
        ],
      );
    } else {
      return Text(
        data.sNo < 10 ? "C0${data.sNo}" : "C${data.sNo}",
        style: TextStyle(
          color: MyColors.c_f99fae,
          fontSize: MyFontSizes.s_10,
        ),
      );
    }
  }
}

class CourseCommentWidget extends StatelessWidget {
  final CourseComment data;

  const CourseCommentWidget(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: MySizes.s_10,
        top: MySizes.s_18,
        right: MySizes.s_20,
        bottom: MySizes.s_18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          loadImage(
            data.headUrl,
            width: MySizes.s_46,
            height: MySizes.s_46,
            shape: BoxShape.circle,
          ),
          Expanded(
            child: PaddingWidget(
              left: MySizes.s_8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data.nickName,
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateUtils.formatDateStr(
                          data.createdAt,
                          format: DataFormats.y_mo_d,
                        ),
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_12,
                        ),
                      ),
                    ],
                  ),
                  PaddingWidget(
                    top: MySizes.s_10,
                    child: Text(
                      data.content,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
      child: Image(
        width: double.infinity,
        image: MyImages.ic_mine_banner,
        fit: BoxFit.cover,
      ),
    );
  }
}

class XmlyPlayCountWidget extends StatelessWidget {
  final int playCount;

  const XmlyPlayCountWidget({
    Key key,
    @required this.playCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MySizes.s_4,
        vertical: MySizes.s_5,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(topRight: Radius.circular(MySizes.s_3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(image: MyImages.ic_xmly_playcount),
          SizedBox(width: MySizes.s_3),
          Text(
            NumberUtils.getPlayCount(context, playCount),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class XmlyAlbumWidget extends StatelessWidget {
  final Album data;
  final int type;
  final int orderNum;
  final GestureTapCallback onTap;

  static const TYPE_NORMAL = 1; //普通列表
  static const TYPE_RECENT = 2; //最近播放

  const XmlyAlbumWidget({
    Key key,
    @required this.data,
    this.type = TYPE_NORMAL,
    this.orderNum,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return GestureDetector(
      onTap: onTap ??
          () =>
              RoutersNavigate().navigateToXmlyAlbumDetailPage(context, data.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(
          left: MySizes.s_3,
          top: MySizes.s_3,
          right: MySizes.s_8,
          bottom: MySizes.s_3,
        ),
        margin: EdgeInsets.symmetric(horizontal: MySizes.s_4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MySizes.s_3),
        ),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadImage(
                  data.coverUrlSmall,
                  width: 75,
                  height: 75,
                ),
                Positioned(
                  left: 0,
                  top: 6,
                  child: Image(image: MyImages.ic_xmly_logo),
                ),
              ],
            ),
            SizedBox(width: MySizes.s_14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MySizes.s_4),
                  _buildTitle(gm),
                  SizedBox(height: MySizes.s_10),
                  _buildIntro(),
                  SizedBox(height: MySizes.s_8),
                  _buildData(context, gm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(GmLocalizations gm) {
    return data.isFinished == 2
        ? Text.rich(
            TextSpan(children: [
              WidgetSpan(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MySizes.s_4,
                    vertical: MySizes.s_1,
                  ),
                  margin: EdgeInsets.only(right: MySizes.s_6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.c_ff93a4,
                      width: MySizes.s_1,
                    ),
                    borderRadius: BorderRadius.circular(MySizes.s_3),
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
                  fontSize: MyFontSizes.s_15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            data.albumTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: MyColors.c_686868,
              fontSize: MyFontSizes.s_15,
              fontWeight: FontWeight.bold,
            ),
          );
  }

  Widget _buildIntro() {
    return Text(
      data.shortIntro ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: MyColors.c_797979,
        fontSize: MyFontSizes.s_12,
      ),
    );
  }

  Widget _buildData(BuildContext context, GmLocalizations gm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            type == TYPE_NORMAL
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(image: MyImages.ic_xmly_playcount_list),
                      SizedBox(width: MySizes.s_6),
                      Text(
                        NumberUtils.getPlayCount(context, data.playCount),
                        style: TextStyle(
                          color: MyColors.c_797979,
                          fontSize: MySizes.s_11,
                        ),
                      ),
                      SizedBox(width: MySizes.s_12),
                    ],
                  )
                : SizedBox(),
            Image(
                image: type == TYPE_NORMAL
                    ? MyImages.ic_xmly_partnum
                    : MyImages.ic_xmly_recent_play),
            SizedBox(width: MySizes.s_6),
            Text(
              "${type == TYPE_NORMAL ? data.includeTrackCount : orderNum + 1}${gm.xmlyPartNumUnit}",
              style: TextStyle(
                color: MyColors.c_797979,
                fontSize: MySizes.s_11,
              ),
            ),
          ],
        ),
        Text(
          gm.xmlySourceTitle,
          style: TextStyle(
            color: MyColors.c_797979,
            fontSize: MySizes.s_11,
          ),
        ),
      ],
    );
  }
}

class XmlyAlbumEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: MyColors.c_f0f0f0,
      child: Image(image: MyImages.ic_xmly_album_empty),
    );
  }
}

class XmlyPlayListWidget extends StatefulWidget {
  final bool isAsc;
  final ValueChanged valueChanged;

  const XmlyPlayListWidget({
    Key key,
    @required this.isAsc,
    this.valueChanged,
  }) : super(key: key);

  @override
  _XmlyPlayListWidgetState createState() =>
      _XmlyPlayListWidgetState(isAsc, valueChanged);
}

class _XmlyPlayListWidgetState extends State<XmlyPlayListWidget> {
  final ValueChanged valueChanged;
  final RefreshController _refreshController = RefreshController();
  IPlayStatusCallback _iPlayStatusCallback;
  Track _currTrack; //当前正在播放的声音
  List<Track> _tracks; //播放列表数据
  PlayMode _playMode; //播放类型
  bool _isAsc; //是否升序
  int _pageIndex; //分页索引

  _XmlyPlayListWidgetState(bool isAsc, this.valueChanged) : _isAsc = isAsc;

  @override
  void initState() {
    _initTrack();
    _initListener();
    super.initState();
  }

  @override
  void dispose() {
    if (_iPlayStatusCallback != null)
      Xmly().removePlayerStatusListener(_iPlayStatusCallback);
    super.dispose();
  }

  _initTrack() async {
    _currTrack = await Xmly().getCurrSound();
    _tracks = await Xmly().getPlayList();
    _playMode = await Xmly().getPlayMode();
    if (mounted) {
      setState(() {});
    }
  }

  _initListener() {
    _iPlayStatusCallback ??= IPlayStatusCallback();
    _iPlayStatusCallback.onSoundSwitch = () async {
      _currTrack = await Xmly().getCurrSound();
      if (mounted) {
        setState(() {});
      }
    };
    Xmly().addPlayerStatusListener(_iPlayStatusCallback);
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Container(
      color: Colors.white,
      height: ScreenUtils.height * 478 / 667,
      child: Column(
        children: <Widget>[
          SizedBox(height: MySizes.s_20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => _onTapPlayMode(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MySizes.s_16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                          image: _playMode == PlayMode.PLAY_MODEL_SINGLE_LOOP
                              ? MyImages.ic_xmly_play_modesingle
                              : _playMode == PlayMode.PLAY_MODEL_RANDOM
                                  ? MyImages.ic_xmly_play_moderandom
                                  : _playMode == PlayMode.PLAY_MODEL_LIST_LOOP
                                      ? MyImages.ic_xmly_play_modelistrecycle
                                      : MyImages.ic_xmly_play_modelist),
                      SizedBox(width: MySizes.s_12),
                      Text(
                        _playMode == PlayMode.PLAY_MODEL_SINGLE_LOOP
                            ? gm.xmlyPlayModeSigleLoop
                            : _playMode == PlayMode.PLAY_MODEL_RANDOM
                                ? gm.xmlyPlayModeRandom
                                : _playMode == PlayMode.PLAY_MODEL_LIST_LOOP
                                    ? gm.xmlyPlayModeListLoop
                                    : gm.xmlyPlayModeList,
                        style: TextStyle(
                          color: MyColors.c_585858,
                          fontSize: MyFontSizes.s_14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onTapSort(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MySizes.s_16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                          image: _isAsc
                              ? MyImages.ic_xmly_album_desc
                              : MyImages.ic_xmly_album_asc),
                      SizedBox(width: MySizes.s_12),
                      Text(
                        _isAsc ? gm.xmlyPlaySortDesc : gm.xmlyPlaySortAsc,
                        style: TextStyle(
                          color: MyColors.c_585858,
                          fontSize: MyFontSizes.s_14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MySizes.s_20),
          Expanded(
            child: _tracks != null
                ? SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: isEnablePullDown,
                    enablePullUp: isEnablePullUp,
                    onRefresh: () => _onRefresh(),
                    onLoading: () => _onLoading(),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Track data = _tracks[index];
                        return GestureDetector(
                          onTap: () => _onTapItem(index),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MySizes.s_14,
                                  vertical: MySizes.s_16,
                                ),
                                child: Text(
                                  data.trackTitle,
                                  style: TextStyle(
                                    color: data.id == _currTrack.id
                                        ? MyColors.c_ffa2b1
                                        : MyColors.c_585858,
                                    fontSize: MyFontSizes.s_15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Divider(
                                height: MySizes.s_1,
                                color: MyColors.c_f4f4f4,
                                indent: MySizes.s_14,
                              ),
                            ],
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: _tracks?.length ?? 0,
                    ),
                  )
                : Container(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  bool get isEnablePullDown {
    if (_isAsc) {
      return XmlyData.prePage > 1;
    } else {
      return XmlyData.page < XmlyData.totalPage;
    }
  }

  bool get isEnablePullUp {
    if (XmlyData.isAsc) {
      return XmlyData.page < XmlyData.totalPage;
    } else {
      return XmlyData.prePage > 1;
    }
  }

  _onRefresh() async {
    try {
      if (_isAsc) {
        XmlyData.prePage--;
        _pageIndex = XmlyData.prePage;
      } else {
        XmlyData.page++;
        _pageIndex = XmlyData.page;
      }
      TrackPageList trackPageList = await XmlyNetManager().getTracks(
        albumId: XmlyData.albumId,
        sort: XmlyData.isAsc ? XmlyData.ASC : XmlyData.DESC,
        page: _pageIndex,
      );
      if (trackPageList != null &&
          trackPageList.tracks != null &&
          trackPageList.tracks.isNotEmpty) {
        List<Track> list = trackPageList.tracks;
        _tracks.insertAll(0, list);
        await Xmly().insertTracksToPlayListHead(list: list);
        if (mounted) {
          setState(() {});
        }
      }
      _refreshController.refreshCompleted();
    } catch (e) {
      if (_isAsc) {
        XmlyData.prePage++;
      } else {
        XmlyData.page--;
      }
      _refreshController.refreshFailed();
    }
  }

  _onLoading() async {
    try {
      if (_isAsc) {
        XmlyData.page++;
        _pageIndex = XmlyData.page;
      } else {
        XmlyData.prePage--;
        _pageIndex = XmlyData.prePage;
      }
      TrackPageList trackPageList = await XmlyNetManager().getTracks(
        albumId: XmlyData.albumId,
        sort: XmlyData.isAsc ? XmlyData.ASC : XmlyData.DESC,
        page: _pageIndex,
      );
      if (trackPageList != null &&
          trackPageList.tracks != null &&
          trackPageList.tracks.isNotEmpty) {
        List<Track> list = trackPageList.tracks;
        _tracks.addAll(list);
        await Xmly().addTracksToPlayList(list: list);
        if (mounted) {
          setState(() {});
        }
      }
      _refreshController.loadComplete();
    } catch (e) {
      if (_isAsc) {
        XmlyData.page--;
      } else {
        XmlyData.prePage++;
      }
      _refreshController.loadFailed();
    }
  }

  _onTapItem(int index) {
    Xmly().play(playIndex: index);
  }

  _onTapPlayMode() {
    if (_playMode == PlayMode.PLAY_MODEL_LIST) {
      _playMode = PlayMode.PLAY_MODEL_SINGLE_LOOP;
    } else if (_playMode == PlayMode.PLAY_MODEL_SINGLE_LOOP) {
      _playMode = PlayMode.PLAY_MODEL_RANDOM;
    } else if (_playMode == PlayMode.PLAY_MODEL_RANDOM) {
      _playMode = PlayMode.PLAY_MODEL_LIST_LOOP;
    } else {
      _playMode = PlayMode.PLAY_MODEL_LIST;
    }
    Xmly().setPlayMode(mode: _playMode);
  }

  _onTapSort() async {
    _isAsc = !_isAsc;
    _tracks = _tracks.reversed;
    await Xmly().permutePlayList();
    if (valueChanged != null) {
      valueChanged.call(_isAsc);
    }
    if (mounted) {
      setState(() {});
    }
  }
}

class XmlyTimerCloseWidget extends StatelessWidget {
  final ValueChanged valueChanged;

  const XmlyTimerCloseWidget({Key key, this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(
          width: double.infinity,
          fit: BoxFit.cover,
          image: MyImages.ic_xmly_playtimer_daynight,
        ),
        Container(
          color: Colors.white,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: MySizes.s_40,
            crossAxisSpacing: MySizes.s_26,
            padding: EdgeInsets.symmetric(
              horizontal: MySizes.s_36,
              vertical: MySizes.s_30,
            ),
            childAspectRatio: 138 / 43,
            shrinkWrap: true,
            children: <Widget>[
              _buildItem(context, 0, gm),
              _buildItem(context, 1, gm),
              _buildItem(context, 2, gm),
              _buildItem(context, 3, gm),
            ],
          ),
        ),
        DividerWidget(
          width: double.infinity,
          color: MyColors.c_f4f4f4,
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: MySizes.s_20,
            ),
            child: Text(
              gm.xmlyPlayTimerCloseDialogCloseTitle,
              style: TextStyle(
                color: MyColors.c_585858,
                fontSize: MyFontSizes.s_14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index, GmLocalizations gm) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        if (valueChanged != null) {
          valueChanged.call(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: MySizes.s_14),
        decoration: BoxDecoration(
          color: MyColors.c_f4f4f4,
          borderRadius: BorderRadius.circular(MySizes.s_30),
        ),
        child: Text(
          index == 3
              ? gm.xmlyPlayTimerCloseDialogCancelTitle
              : "${index == 0 ? 15 : index == 1 ? 30 : 60}${gm.xmlyPlayTimerCloseDialogTimeUnit}",
          style: TextStyle(
            color: MyColors.c_585858,
            fontSize: MyFontSizes.s_14,
          ),
        ),
      ),
    );
  }
}
