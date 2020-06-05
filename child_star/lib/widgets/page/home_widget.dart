import 'dart:math';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeNewsItemWidget extends StatelessWidget {
  final News data;
  final GestureTapCallback onTap;

  const HomeNewsItemWidget({Key key, this.data, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => RoutersNavigate()
              .navigateToNewDetail(context, data.id.toString()),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            MySizes.s_4, MySizes.s_4, MySizes.s_4, MySizes.s_6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(MySizes.s_3),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadImage(
                  data.headUrl,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(MySizes.s_3),
                ),
                Container(
                    padding: EdgeInsets.all(MySizes.s_5),
                    child: (data.type == 1 || data.type == 2)
                        ? Image(image: MyImagesMultiple.home_media[data.type])
                        : EmptyWidget()),
                Positioned(
                  right: MySizes.s_5,
                  bottom: MySizes.s_5,
                  child: Container(
                    padding: EdgeInsets.all(MySizes.s_5),
                    decoration: BoxDecoration(
                      color: MyColorsFul.home_tag[Random().nextInt(6)],
                      borderRadius: BorderRadius.circular(MySizes.s_11),
                      border: Border.all(
                        color: Colors.white,
                        width: MySizes.s_1,
                      ),
                    ),
                    child: Text(
                      data.innerWord,
                      style: TextStyle(
                          color: Colors.white, fontSize: MyFontSizes.s_12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: MySizes.s_7),
              child: Text(
                data.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: MyColors.c_686868, fontSize: MyFontSizes.s_12),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: MySizes.s_30),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MySizes.s_6),
                        child: Image(image: MyImages.ic_homenew_look),
                      ),
                      Text(
                        data.lookRecord != null
                            ? data.lookRecord.toString()
                            : "0",
                        style: TextStyle(
                            color: MyColors.c_7f7f7f,
                            fontSize: MyFontSizes.s_14),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: MySizes.s_6),
                        color: MyColors.c_7f7f7f,
                        width: MySizes.s_1,
                        height: MySizes.s_12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MySizes.s_6),
                        child: Image(
                            image: MyImagesMultiple
                                .home_collection[data.isLike ?? false]),
                      ),
                      Text(
                        data.like != null ? data.like.toString() : "0",
                        style: TextStyle(
                            color: MyColors.c_7f7f7f,
                            fontSize: MyFontSizes.s_14),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

///资讯点赞、收藏、评论、下载Widget 互动
class NewsInteractionWidget extends StatefulWidget {
  final int type; //点赞类型：1：资讯；2：讲堂(非课程)；3：资讯评论（id传评论id）
  final NewsDetail data;
  final DbUtils dbUtils;

  NewsInteractionWidget({
    @required this.type,
    @required this.data,
    @required this.dbUtils,
  })  : assert(type != null),
        assert(data != null),
        assert(dbUtils != null);

  @override
  _NewsInteractionWidgetState createState() =>
      _NewsInteractionWidgetState(type, data, dbUtils);
}

class _NewsInteractionWidgetState extends State<NewsInteractionWidget> {
  final int type; //点赞类型：1：资讯；2：讲堂(非课程)；3：资讯评论（id传评论id）
  NewsDetail data;
  final DbUtils dbUtils;

  _NewsInteractionWidgetState(this.type, this.data, this.dbUtils);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(height: MySizes.s_1, color: MyColors.c_d5d5d5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MySizes.s_10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildItem(
                  MyImagesMultiple.like_status[data.isLike],
                  data.like.toString(),
                  onTap: () => _doLike(),
                ),
                _buildItem(
                  MyImagesMultiple.collection_status[data.isCollect],
                  data.collect.toString(),
                  onTap: () => _doCollect(),
                ),
                _buildItem(
                    MyImages.ic_newdetail_comment, data.comment.toString()),
                data.mediaUrl != null && data.mediaUrl.isNotEmpty
                    ? _buildItem(
                        MyImages.ic_newdetail_download,
                        GmLocalizations.of(context).newDetailDownloadTitle,
                        onTap: () => _doDownload(),
                      )
                    : EmptyWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(AssetImage image, String text, {GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(image: image),
          Padding(padding: EdgeInsets.only(left: MySizes.s_8)),
          Text(
            text,
            style:
                TextStyle(color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
          ),
        ],
      ),
    );
  }

  _doLike() async {
    try {
      Result result =
          await NetManager(context).doLike(id: data.id.toString(), type: type);
      if (result.status == 1) {
        //已点赞
        data.isLike = true;
        data.like++;
      } else {
        //未点赞
        data.isLike = false;
        data.like--;
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      LogUtils.e(e);
    }
  }

  _doCollect() async {
    try {
      Result result = await NetManager(context)
          .doCollection(id: data.id.toString(), type: type);
      if (result.status == 1) {
        //已收藏
        data.isCollect = true;
        data.collect++;
      } else {
        //未收藏
        data.isCollect = false;
        data.collect--;
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      LogUtils.e(e);
    }
  }

  _doDownload() async {
    GmLocalizations gm = GmLocalizations.of(context);
    bool isInsert = await dbUtils.isMediaCacheInsert(data.id);
    if (isInsert) {
      //1：视频；2：音频
      showToast(data.type == 1
          ? gm.newDetailDownloadVideoToast
          : gm.newDetailDownloadAudioToast);
      return;
    }
    String downloadUrl = data.mediaUrl;
    var result =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (result[PermissionGroup.storage] == PermissionStatus.granted) {
      var fileName = downloadUrl
          .substring(downloadUrl.lastIndexOf(FileUtils.separator) + 1);
      var savePath = await FileUtils.getDownloadPath(fileName);
      await Net(context).download(downloadUrl, savePath);
      await dbUtils.open();
      var result = await dbUtils.insert(MediaCache()
        ..type = type
        ..mediaId = data.id
        ..mediaType = data.type
        ..imageUrl = data.headUrl
        ..title = data.title
        ..desc = data.partContent
        ..url = data.mediaUrl
        ..path = savePath);
      LogUtils.i("insert result: $result");
      showToast(gm.newDetailDownloadCompleteToast);
    }
  }
}

//资讯关注
class NewsFollowWidget extends StatelessWidget {
  final String authorId;
  final bool isConcern;
  final GestureTapCallback onTap;

  const NewsFollowWidget({
    Key key,
    @required this.authorId,
    @required this.isConcern,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return GestureDetector(
      onTap: () => _doFollow(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(left: MySizes.s_8, top: MySizes.s_8),
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_8,
          vertical: MySizes.s_4,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: MyColors.c_777777,
            width: MySizes.s_1,
          ),
          borderRadius: BorderRadius.circular(MySizes.s_3),
        ),
        child: Text(
          isConcern ? gm.newDetailFollowTitle : "+${gm.newDetailUnFollowTitle}",
          style:
              TextStyle(color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
        ),
      ),
    );
  }

  _doFollow(BuildContext context) async {
    try {
      Result result = await NetManager(context).doFollow(authorId: authorId);
      //1：已关注 0：未关注
      Provider.of<FollowProvider>(context)
          .setConcernData(authorId, result.status == 1);
    } catch (e) {
      LogUtils.e(e);
    }
  }
}

class NewsItemWidget extends StatelessWidget {
  final News data;
  final GestureTapCallback onTap;

  const NewsItemWidget(this.data, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          RoutersNavigate().navigateToNewDetail(context, data.id.toString());
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: MySizes.s_24, right: MySizes.s_16, bottom: MySizes.s_14),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadImage(
                  data.headUrl,
                  borderRadius: BorderRadius.circular(MySizes.s_3),
                  width: MySizes.s_155,
                  height: MySizes.s_105,
                  fit: BoxFit.cover,
                ),
                data.mediaTime.isEmpty
                    ? EmptyWidget()
                    : Positioned(
                        right: MySizes.s_4,
                        bottom: MySizes.s_4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: MySizes.s_8, vertical: MySizes.s_4),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(MySizes.s_3),
                          ),
                          child: Text(
                            TimeUtils.formatDateS(data.mediaTime),
                            style: TextStyle(
                                color: MyColors.c_777777,
                                fontSize: MyFontSizes.s_10),
                          ),
                        ),
                      ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: MySizes.s_14),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: MySizes.s_104),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: MySizes.s_8)),
                      Text(
                        "#${data.innerWord}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.c_777777,
                            fontSize: MyFontSizes.s_12),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WebViewWidget extends StatefulWidget {
  final String data;

  const WebViewWidget({Key key, this.data}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState(data);
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final String data;
  double height;

  _WebViewWidgetState(this.data);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    if (AppUtils.isMobile) {
      return Container(
        height: height ?? screenHeight,
        child: InAppWebView(
          initialData: InAppWebViewInitialData(
            data: transformHtml(data),
          ),
          initialOptions: InAppWebViewWidgetOptions(
            inAppWebViewOptions: InAppWebViewOptions(
              disableVerticalScroll: true,
              verticalScrollBarEnabled: false,
            ),
          ),
          onLoadStop: (controller, url) {
            controller.evaluateJavascript(source: JS_HTML_HEIGHT).then((value) {
              var valueDp = value / devicePixelRatio;
              if (valueDp < screenHeight) {
                height = valueDp;
                setState(() {});
              }
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }
}

class HomeSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;

  const HomeSearchWidget({
    Key key,
    this.controller,
    this.hintText,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MySizes.s_4,
        vertical: MySizes.s_8,
      ),
      decoration: BoxDecoration(
        color: MyColors.c_f7f7f7,
        borderRadius: BorderRadius.circular(MySizes.s_14),
        border: Border.all(
          color: MyColors.c_ececec,
          width: MySizes.s_1,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: 1,
        style: TextStyle(
          color: MyColors.c_797979,
          fontSize: MyFontSizes.s_13,
        ),
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: MySizes.s_8),
            child: Image(
              image: MyImages.ic_home_search,
              width: MySizes.s_18,
              height: MySizes.s_18,
            ),
          ),
          hintText: hintText ?? gm.searchHintTitle,
          hintStyle:
              TextStyle(color: MyColors.c_b6b6b6, fontSize: MyFontSizes.s_13),
          contentPadding: EdgeInsets.only(
            right: MySizes.s_12,
            top: MySizes.s_8,
            bottom: MySizes.s_8,
          ),
          border: InputBorder.none,
          isDense: true,
        ),
        onSubmitted: (s) {
          if (s.isEmpty) {
            showToast(gm.searchEmptyToast);
            return;
          }
          if (onSubmitted != null) {
            onSubmitted(s);
          }
        },
      ),
    );
  }
}

class HomeSearchTagWidget extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const HomeSearchTagWidget({
    Key key,
    @required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_10,
          vertical: MySizes.s_4,
        ),
        decoration: BoxDecoration(
          color: MyColors.c_fcf9f4,
          borderRadius: BorderRadius.circular(MySizes.s_10),
          border: Border.all(
            color: MyColors.c_dadada,
            width: MySizes.s_1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: MyColors.c_878778,
            fontSize: MyFontSizes.s_12,
          ),
        ),
      ),
    );
  }
}

class HomeTopBarWidget extends StatelessWidget {
  final currentIndex;
  final List<String> data;
  final ValueChanged<int> onTap;

  HomeTopBarWidget({
    @required this.currentIndex,
    @required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MyColors.c_f7f7f7,
        borderRadius: BorderRadius.circular(MySizes.s_20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            data.asMap().keys.map((e) => _buildTopMenu(data[e], e)).toList(),
      ),
    );
  }

  Widget _buildTopMenu(String text, int index) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: currentIndex == index ? MyColors.c_ffa2b1 : MyColors.c_f7f7f7,
          borderRadius: BorderRadius.circular(MySizes.s_20),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MySizes.s_18,
              vertical: MySizes.s_4,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: currentIndex == index ? Colors.white : MyColors.c_a4a4a4,
                fontSize: MyFontSizes.s_15,
              ),
            )),
      ),
      behavior: HitTestBehavior.opaque, //点击padding区域也有效
      onTap: () {
        if (onTap != null) {
          onTap(index);
        }
      },
    );
  }
}
