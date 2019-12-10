import 'dart:ui';

import 'package:child_star/common/config.dart';
import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/my_systems.dart';
import 'package:child_star/common/net/net_config.dart';
import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/date_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

typedef OnNewsItemClick(News news);

///资讯详情
class NewDetailPage extends StatefulWidget {
  final String newId;

  NewDetailPage(this.newId);

  @override
  _NewDetailPageState createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage> {
  Future<NewsDetail> _newsDetailFuture;

  @override
  void initState() {
    _newsDetailFuture = NetManager(context).getNewsDetail(widget.newId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var onNewsItemClick = (news) {
      setState(() {
        _newsDetailFuture =
            NetManager(context).getNewsDetail(news.id.toString());
      });
    };
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: FutureBuilderWidget<NewsDetail>(
            future: _newsDetailFuture,
            onErrorRetryTap: () {
              setState(() {
                _newsDetailFuture =
                    NetManager(context).getNewsDetail(widget.newId);
              });
            },
            builder: (context, snapshot) {
              NewsDetail data = snapshot.data;
              return Column(
                children: <Widget>[
                  AppBarWidget(data != null ? data.title : ""),
                  _buildVideoPlayer(data),
                  _NewDetailBody(data, onNewsItemClick),
                  _NewDetailBottom(data),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildVideoPlayer(NewsDetail data) {
    //0：图文 | 1:：视频 | 2：音频 | 3：百科
    if (data != null && data.type == MediaType.VIDEO) {
      return VideoPlayerWidget(data.mediaUrl);
    } else {
      return EmptyWidget();
    }
  }
}

class _NewDetailBody extends StatelessWidget {
  final NewsDetail data;
  final OnNewsItemClick onNewsItemClick;

  _NewDetailBody(this.data, this.onNewsItemClick);

  @override
  Widget build(BuildContext context) {
    final GmLocalizations gm = GmLocalizations.of(context);
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(),
          _buildAudioPlayer(),
          _buildBody(gm),
          _buildBottom(gm),
          _buildList(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    //0：图文 | 1:：视频 | 2：音频 | 3：百科
    if (data.type == MediaType.VIDEO) {
      return SliverToBoxAdapter(child: EmptyWidget());
    } else {
      return SliverPersistentHeader(
        delegate: CustomSliverPersistentHeaderDelegate(
            minHeight: 0,
            maxHeight: ScreenUtils.width * 250 / 375,
            child: cachedNetworkImage(data.headUrl, fit: BoxFit.cover)),
      );
    }
  }

  Widget _buildAudioPlayer() {
    //0：图文 | 1:：视频 | 2：音频 | 3：百科
    if (data.type == MediaType.AUDIO) {
      return SliverPadding(
        padding: EdgeInsets.only(top: MySizes.s_6),
        sliver: SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverPersistentHeaderDelegate(
            minHeight: MySizes.s_54,
            maxHeight: MySizes.s_55,
            child: AudioPlayerWidget(data.mediaUrl),
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(child: EmptyWidget());
    }
  }

  Widget _buildBody(GmLocalizations gm) {
    var tags = "# ";
    final readNum = "${gm.newDetailReadingNumTitle} : ${data.lookRecord}";
    List<Tag> tagList = data.tags;
    if (tagList != null && tagList.isNotEmpty) {
      if (tagList.length > 3) {
        tagList = tagList.sublist(0, 3);
      }
      tagList.forEach((tag) {
        tags = tags + tag.name + " ";
      });
      tags = "$tags/ $readNum";
    } else {
      tags = readNum;
    }
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: MySizes.s_20, top: MySizes.s_14, right: MySizes.s_20),
            child: Text(
              data.title,
              style: TextStyle(
                color: MyColors.c_777777,
                fontSize: MyFontSizes.s_17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_20, vertical: MySizes.s_16),
            child: Text(
              tags,
              style: TextStyle(
                  color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MySizes.s_20, bottom: MySizes.s_16, right: MySizes.s_20),
            child: Text(
              data.partContent,
              style: TextStyle(
                  color: MyColors.c_777777, fontSize: MyFontSizes.s_15),
            ),
          ),
          Divider(height: MySizes.s_1, color: MyColors.c_d5d5d5),
          Padding(
            padding: EdgeInsets.only(
              left: MySizes.s_20,
              top: MySizes.s_6,
              right: MySizes.s_14,
              bottom: MySizes.s_6,
            ),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    cachedNetworkImage(
                      data.authorHeadUrl,
                      isCircle: true,
                      width: MySizes.s_46,
                      height: MySizes.s_46,
                    ),
                    Positioned(
                      right: -MySizes.s_2,
                      bottom: -MySizes.s_2,
                      child: Image(image: MyImages.ic_newdetail_authenticate),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MySizes.s_12,
                        top: MySizes.s_16,
                        bottom: MySizes.s_16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.authorName,
                          style: TextStyle(
                              color: MyColors.c_777777,
                              fontSize: MyFontSizes.s_12,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MySizes.s_6),
                          child: Text(
                            data.authorIntroduction,
                            style: TextStyle(
                                color: MyColors.c_777777,
                                fontSize: MyFontSizes.s_10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: MySizes.s_8, top: MySizes.s_8),
                  padding: EdgeInsets.symmetric(
                      horizontal: MySizes.s_8, vertical: MySizes.s_4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.c_777777,
                      width: MySizes.s_1,
                    ),
                    borderRadius: BorderRadius.circular(MySizes.s_3),
                  ),
                  child: Text(
                    data.isConcern
                        ? gm.newDetailFollowTitle
                        : "+${gm.newDetailUnFollowTitle}",
                    style: TextStyle(
                        color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: MySizes.s_1, color: MyColors.c_d5d5d5),
        ],
      ),
    );
  }

  Widget _buildBottom(GmLocalizations gm) {
    //0：图文 | 1:：视频 | 2：音频 | 3：百科
    if (data.type == MediaType.VIDEO) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(
              left: MySizes.s_24, top: MySizes.s_16, bottom: MySizes.s_10),
          child: Text(
            gm.newDetailRelateVideoTitle,
            style:
                TextStyle(color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
          ),
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildListDelegate([
          Container(
            height: ScreenUtils.height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MySizes.s_10, vertical: MySizes.s_14),
              child: InAppWebView(
                initialData: InAppWebViewInitialData(
                  data: transformHtml(data.content),
                ),
                initialOptions: InAppWebViewWidgetOptions(
                  inAppWebViewOptions: InAppWebViewOptions(),
                ),
              ),
            ),
          ),
          Divider(height: MySizes.s_1, color: MyColors.c_d5d5d5),
          Padding(
            padding: EdgeInsets.only(
                left: MySizes.s_24, top: MySizes.s_16, bottom: MySizes.s_10),
            child: Text(
              data.type == MediaType.AUDIO
                  ? gm.newDetailRelateAudioTitle
                  : gm.newDetailRelateArticleTitle,
              style: TextStyle(
                  color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
            ),
          ),
        ]),
      );
    }
  }

  Widget _buildList(BuildContext context) {
    //0：图文 | 1:：视频 | 2：音频 | 3：百科
    var tagIds = "";
    List<Tag> tagList = data.tags;
    if (tagList != null && tagList.isNotEmpty) {
      tagList.forEach((tag) {
        tagIds = tagIds + "${tag.id},";
      });
      tagIds = tagIds.substring(0, tagIds.length - 1);
    }
    var future = NetManager(context).getNewsSearchList(
      pageIndex: PAGE_INDEX,
      tagIds: tagIds,
      id: data.id.toString(),
      type: data.type,
    );
    return SliverEmptyFutureBuilderWidget<Newslist>(
        future: future,
        builder: (context, snapshot) {
          List<News> newsList = snapshot.data.resultList;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var model = newsList[index];
                return GestureDetector(
                  onTap: () {
                    if (onNewsItemClick != null) {
                      onNewsItemClick(model);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MySizes.s_24,
                        right: MySizes.s_16,
                        bottom: MySizes.s_14),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            cachedNetworkImage(
                              model.headUrl,
                              borderRadius: MySizes.s_3,
                              width: MySizes.s_155,
                              height: MySizes.s_105,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: MySizes.s_4,
                              bottom: MySizes.s_4,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MySizes.s_8,
                                    vertical: MySizes.s_4),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                      BorderRadius.circular(MySizes.s_3),
                                ),
                                child: Text(
                                  getTimeFromSecond(model.mediaTime),
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
                              constraints:
                                  BoxConstraints.expand(height: MySizes.s_104),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: MyColors.c_777777,
                                      fontSize: MyFontSizes.s_12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: MySizes.s_8)),
                                  Text(
                                    "#${model.innerWord}",
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
              },
              childCount: newsList.length,
            ),
          );
        });
  }
}

class _NewDetailBottom extends StatelessWidget {
  final NewsDetail newsDetail;

  _NewDetailBottom(this.newsDetail);

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
                _buildItem(MyImages.ic_newdetail_like,
                    newsDetail?.like.toString() ?? ""),
                _buildItem(MyImages.ic_newdetail_collection,
                    newsDetail?.collect.toString() ?? ""),
                _buildItem(MyImages.ic_newdetail_comment,
                    newsDetail?.comment.toString() ?? ""),
                _buildItem(MyImages.ic_newdetail_download,
                    GmLocalizations.of(context).newDetailDownloadTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(AssetImage image, String text) {
    return Row(
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
    );
  }
}
