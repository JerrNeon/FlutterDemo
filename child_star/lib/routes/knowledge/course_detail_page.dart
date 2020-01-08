import 'dart:ui';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/home_widget.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///课程详情
class CourseDetailPage extends StatefulWidget {
  final String courseId;

  CourseDetailPage(this.courseId);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState(courseId);
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final String id;
  Future<CourseDetail> _courseDetailFuture;
  DbUtils _dbUtils;

  _CourseDetailPageState(this.id);

  @override
  void initState() {
    super.initState();
    _initFuture();
    _dbUtils = DbUtils();
  }

  _initFuture() {
    _courseDetailFuture = NetManager(context).getCourseDetail(id);
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
        _courseDetailFuture =
            NetManager(context).getCourseDetail(data.id.toString());
      });
    };
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: FutureBuilderWidget<CourseDetail>(
            future: _courseDetailFuture,
            onErrorRetryTap: () {
              _initFuture();
              setState(() {});
            },
            builder: (context, snapshot) {
              CourseDetail data = snapshot.data;
              return Column(
                children: <Widget>[
                  AppBarWidget(data != null ? data.title : ""),
                  _buildVideoPlayer(data),
                  _CourseDetailBody(data, onItemClick),
                  NewsInteractionWidget(
                    type: TYPE_LECTURE,
                    data: NewsDetail()
                      ..id = data.id
                      ..headUrl = data.headUrl
                      ..title = data.courseTitle
                      ..partContent = data.courseDescr
                      ..mediaUrl = data.mediaUrl
                      ..type = data.type
                      ..isLike = data.isLike
                      ..like = data.like
                      ..isCollect = data.isCollect
                      ..collect = data.collect
                      ..comment = data.comment,
                    dbUtils: _dbUtils,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildVideoPlayer(CourseDetail data) {
    //1:：视频 | 2：音频
    if (data != null && data.type == MediaType.VIDEO) {
      return VideoPlayerWidget(data.mediaUrl);
    } else {
      return EmptyWidget();
    }
  }
}

class _CourseDetailBody extends StatelessWidget {
  final CourseDetail data;
  final OnItemClick<Course> onItemClick;

  _CourseDetailBody(this.data, this.onItemClick);

  @override
  Widget build(BuildContext context) {
    final GmLocalizations gm = GmLocalizations.of(context);
    return Expanded(
      child: data.comment > 0
          ? SmartRefresherWidget<CourseComment>(
              enablePullDown: false,
              onRefreshLoading: (pageIndex) =>
                  NetManager(context).getCourseCommentList(
                id: data.id.toString(),
                pageIndex: pageIndex,
              ),
              builder: (context, data) =>
                  _buildCustomScrollView(context, gm, data),
            )
          : _buildCustomScrollView(context, gm, null),
    );
  }

  Widget _buildCustomScrollView(
      BuildContext context, GmLocalizations gm, List<CourseComment> list) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildHeader(),
        _buildAudioPlayer(),
        _buildBody(),
        _buildBottom(gm),
        _buildCourseList(context),
        _buildCommentTop(gm),
        _buildCommentList(gm, list),
      ],
    );
  }

  Widget _buildHeader() {
    //1:：视频 | 2：音频
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
    //1:：视频 | 2：音频
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

  Widget _buildBody() {
    var tags = "# ";
    var time = TimeUtils.formatDateS(data.mediaTime);
    List<Tag> tagList = data.tags;
    if (tagList != null && tagList.isNotEmpty) {
      if (tagList.length > 3) {
        tagList = tagList.sublist(0, 3);
      }
      tagList.forEach((tag) {
        tags = tags + tag.name + " ";
      });
      tags = "$tags/ $time";
    } else {
      tags = time;
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
        ],
      ),
    );
  }

  Widget _buildBottom(GmLocalizations gm) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MySizes.s_10,
            vertical: MySizes.s_14,
          ),
          child: WebViewWidget(data: data.instruction),
        ),
        Divider(height: MySizes.s_1, color: MyColors.c_d5d5d5),
        Padding(
          padding: EdgeInsets.only(
              left: MySizes.s_12, top: MySizes.s_24, bottom: MySizes.s_10),
          child: Text(
            gm.courseRelateTitle,
            style: TextStyle(
              color: MyColors.c_686868,
              fontSize: MyFontSizes.s_12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildCourseList(BuildContext context) {
    var future = NetManager(context).getCoursePartList(
      id: data.cId.toString(),
      partNo: data.partNo,
    );
    return SliverEmptyFutureBuilderWidget<PageList<Course>>(
        future: future,
        builder: (context, snapshot) {
          List<Course> list = snapshot.data.resultList;
          list?.removeWhere((e) => e.id == data.id);
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var model = list[index];
                return Column(
                  children: <Widget>[
                    CourseItemWidget(
                      model,
                      1,
                      onTap: () {
                        if (onItemClick != null) {
                          onItemClick(context, model);
                        }
                      },
                    ),
                    Divider(
                      color: MyColors.c_e5e5e5,
                      height: MySizes.s_1,
                    ),
                  ],
                );
              },
              childCount: list.length,
            ),
          );
        });
  }

  Widget _buildCommentTop(GmLocalizations gm) {
    return SliverPadding(
      padding: EdgeInsets.only(left: MySizes.s_12, top: MySizes.s_24),
      sliver: SliverToBoxAdapter(
        child: Text(
          gm.courseCommentTitle,
          style: TextStyle(
            color: MyColors.c_686868,
            fontSize: MyFontSizes.s_12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCommentList(GmLocalizations gm, List<CourseComment> list) {
    if (list != null && list.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            children: <Widget>[
              CourseCommentWidget(list[index]),
              PaddingWidget(
                left: MySizes.s_70,
                child: Divider(
                  color: MyColors.c_bababa,
                  height: MySizes.s_1,
                ),
              ),
            ],
          ),
          childCount: list?.length ?? 0,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(
          height: MySizes.s_60,
          alignment: Alignment.center,
          child: Text(
            gm.courseCommentNoDataText,
            style: TextStyle(
              color: MyColors.c_686868,
              fontSize: MyFontSizes.s_12,
            ),
          ),
        ),
      );
    }
  }
}
