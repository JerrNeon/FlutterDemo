import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class XmlyAlbumDetailPage extends StatefulWidget {
  final int albumId;

  const XmlyAlbumDetailPage({Key key, @required this.albumId})
      : super(key: key);
  @override
  _XmlyAlbumDetailPageState createState() => _XmlyAlbumDetailPageState(albumId);
}

class _XmlyAlbumDetailPageState extends State<XmlyAlbumDetailPage> {
  final int albumId;
  Future<AlbumPageList> _albumFuture;
  Future<TrackPageList> _trackFuture;

  _XmlyAlbumDetailPageState(this.albumId);

  @override
  void initState() {
    //设置状态栏透明
    SystemChrome.setSystemUIOverlayStyle(MySystems.transparent);
    _initAlbumFuture();
    _initTrackFuture();
    super.initState();
  }

  _initAlbumFuture() {
    _albumFuture = XmlyNetManager().getSearchAlbumList(id: albumId);
  }

  _initTrackFuture() {
    _trackFuture = XmlyNetManager().getTracks(albumId: albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      backgroundColor: MyColors.c_6a8994,
      body: Column(
        children: <Widget>[
          _buildTop(),
          SizedBox(height: MySizes.s_8),
          _buildContent(),
          _buildList(),
        ],
      ),
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
            child: Image(image: MyImages.ic_mine_collection),
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

  Widget _buildList() {
    return SizedBox();
  }

  _doCollect() {}
}
