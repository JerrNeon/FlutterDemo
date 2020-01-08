import 'dart:ui';

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

///资讯详情
class NewDetailPage extends StatefulWidget {
  final String newId;

  NewDetailPage(this.newId);

  @override
  _NewDetailPageState createState() => _NewDetailPageState(newId);
}

class _NewDetailPageState extends State<NewDetailPage> {
  final String id;
  Future<NewsDetail> _newsDetailFuture;
  DbUtils _dbUtils;

  _NewDetailPageState(this.id);

  @override
  void initState() {
    _newsDetailFuture = NetManager(context).getNewsDetail(id);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<FollowProvider>(context).reset());
    _dbUtils = DbUtils();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dbUtils?.close();
  }

  @override
  Widget build(BuildContext context) {
    var onItemClick = (context, data) {
      setState(() {
        _newsDetailFuture =
            NetManager(context).getNewsDetail(data.id.toString());
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
                _newsDetailFuture = NetManager(context).getNewsDetail(id);
              });
            },
            builder: (context, snapshot) {
              NewsDetail data = snapshot.data;
              return Column(
                children: <Widget>[
                  AppBarWidget(data != null ? data.title : ""),
                  _buildVideoPlayer(data),
                  _NewDetailBody(data, onItemClick),
                  NewsInteractionWidget(
                    type: TYPE_NEWS,
                    data: data,
                    dbUtils: _dbUtils,
                  ),
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
  final OnItemClick<News> onItemClick;

  _NewDetailBody(this.data, this.onItemClick);

  @override
  Widget build(BuildContext context) {
    final GmLocalizations gm = GmLocalizations.of(context);
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(),
          _buildAudioPlayer(),
          _buildBody(context, gm),
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
            child: loadImage(data.headUrl, fit: BoxFit.cover)),
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

  Widget _buildBody(BuildContext context, GmLocalizations gm) {
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
          //标题
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
          //标签
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_20, vertical: MySizes.s_16),
            child: Text(
              tags,
              style: TextStyle(
                  color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
            ),
          ),
          //简介
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
          //作者信息
          GestureDetector(
            onTap: () => RoutersNavigate()
                .navigateToAuthorPage(context, data.authorId.toString()),
            behavior: HitTestBehavior.opaque,
            child: Padding(
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
                      loadImage(
                        data.authorHeadUrl,
                        shape: BoxShape.circle,
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
                  Consumer<FollowProvider>(builder: (context, value, child) {
                    return NewsFollowWidget(
                      authorId: data.authorId.toString(),
                      isConcern: value.isConcern ?? data.isConcern,
                    );
                  }),
                ],
              ),
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
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_10, vertical: MySizes.s_14),
            child: WebViewWidget(data: data.content),
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
    return SliverEmptyFutureBuilderWidget<PageList<News>>(
        future: future,
        builder: (context, snapshot) {
          List<News> newsList = snapshot.data.resultList;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var model = newsList[index];
                return NewsItemWidget(
                  model,
                  onTap: () {
                    if (onItemClick != null) {
                      onItemClick(context, model);
                    }
                  },
                );
              },
              childCount: newsList.length,
            ),
          );
        });
  }
}
