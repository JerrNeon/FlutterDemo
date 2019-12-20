import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class LectureDetailPage extends StatefulWidget {
  final String id;

  const LectureDetailPage({Key key, this.id}) : super(key: key);

  @override
  _LectureDetailPageState createState() => _LectureDetailPageState(id);
}

class _LectureDetailPageState extends State<LectureDetailPage>
    with SingleTickerProviderStateMixin {
  final String id;
  TabController _tabController;
  List<String> _tabList;
  Future<LectureDetail> _lectureDetailfuture;

  _LectureDetailPageState(this.id);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    initFuture();
  }

  initFuture() {
    _lectureDetailfuture = NetManager(context).getLectureDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    _tabList ??= [
      gm.lectureIntroductionTitle,
      gm.lectureCourseTitle,
      gm.lectureCommentTitle,
    ];
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: FutureBuilderWidget<LectureDetail>(
            future: _lectureDetailfuture,
            onErrorRetryTap: () {
              initFuture();
              setState(() {});
            },
            builder: (context, snapshot) {
              LectureDetail data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppBarWidget(data.title),
                  Expanded(
                    child: NestedScrollView(
                      headerSliverBuilder: (context, _) {
                        return [
                          _buildHeader(gm, data),
                          _buildTabBar(data),
                          _buildBottom(),
                        ];
                      },
                      body: _buildTabBarView(data),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildHeader(GmLocalizations gm, LectureDetail data) {
    return SliverPersistentHeader(
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: MySizes.s_345,
        maxHeight: MySizes.s_345,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //封面图
            Padding(
              padding: EdgeInsets.only(
                left: MySizes.s_4,
                top: MySizes.s_4,
                right: MySizes.s_4,
              ),
              child: loadImage(
                data.headUrl,
                width: double.infinity,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(MySizes.s_4),
              ),
            ),
            //标题
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_4,
                vertical: MySizes.s_12,
              ),
              child: Text(
                data.title,
                style: TextStyle(
                  color: MyColors.c_777777,
                  fontSize: MyFontSizes.s_15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //购课人数和推荐人数
            Padding(
              padding: EdgeInsets.only(left: MySizes.s_4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${gm.lectureBuyNumberTitle}${data.lookNum}",
                    style: TextStyle(
                      color: MyColors.c_777777,
                      fontSize: MyFontSizes.s_12,
                    ),
                  ),
                  Container(
                    color: MyColors.c_777777,
                    width: MySizes.s_1,
                    height: MySizes.s_8,
                    margin: EdgeInsets.symmetric(horizontal: MySizes.s_6),
                  ),
                  Text(
                    "${gm.lectureRecommendNumberTitle}${data.like}",
                    style: TextStyle(
                      color: MyColors.c_777777,
                      fontSize: MyFontSizes.s_12,
                    ),
                  ),
                ],
              ),
            ),
            //课程售价和购买按钮
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        data.price == 0
                            ? "${gm.lectureSalePriceTitle}"
                            : "${gm.lectureSalePriceTitle} ${data.price}",
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Offstage(
                        offstage: data.price != 0,
                        child: Text(
                          "${gm.lectureFreePriceTitle}",
                          style: TextStyle(
                            color: MyColors.c_777777,
                            fontSize: MyFontSizes.s_15,
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: data.price == 0,
                        child: Image(
                          image: MyImages.ic_mine_point,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: MyImages.ic_lecture_buy,
                    ),
                  ),
                ],
              ),
            ),
            //广告图
            Padding(
              padding: EdgeInsets.only(
                left: MySizes.s_4,
                top: MySizes.s_12,
                right: MySizes.s_4,
                bottom: MySizes.s_4,
              ),
              child: Image(
                width: double.infinity,
                image: MyImages.ic_mine_banner,
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              height: MySizes.s_1,
              color: MyColors.c_e5e5e5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(LectureDetail data) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: TabBarSliverPersistentHeaderDelegate(
        TabBar(
          controller: _tabController,
          indicator: BoxDecoration(color: Colors.white),
          indicatorWeight: 0,
          labelColor: MyColors.c_ffa2b1,
          labelStyle: TextStyle(
            fontSize: MyFontSizes.s_15,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: MyColors.c_878778,
          unselectedLabelStyle: TextStyle(
            fontSize: MyFontSizes.s_15,
            fontWeight: FontWeight.bold,
          ),
          tabs: _tabList.map((e) => _buildTabBarItem(e, data)).toList(),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: MySizes.s_1,
        maxHeight: MySizes.s_1,
        child: Divider(
          height: MySizes.s_1,
          color: MyColors.c_e5e5e5,
        ),
      ),
    );
  }

  Widget _buildTabBarItem(String text, LectureDetail data) {
    if (text == _tabList[_tabList.length - 1] && data.comment > 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Tab(text: text),
          Padding(
            padding: const EdgeInsets.only(left: MySizes.s_4),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image(
                  image: MyImages.ic_lecture_comment_tag,
                ),
                Text(
                  data.comment > 99 ? "99+" : data.comment.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MyFontSizes.s_10,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return Tab(text: text);
    }
  }

  Widget _buildTabBarView(LectureDetail data) {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        _IntroductionWidget(
          data,
          tabController: _tabController,
        ),
        _CourseWidget(id, data),
        _CommentWidget(id),
      ],
    );
  }
}

class _IntroductionWidget extends StatelessWidget {
  final LectureDetail data;
  final TabController tabController;

  const _IntroductionWidget(
    this.data, {
    Key key,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        _buildHeader(gm),
        _buildPartList(gm),
        _buildBottom(gm),
        _buildList(),
      ],
    );
  }

  Widget _buildHeader(GmLocalizations gm) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTag(gm.lectureCourseIntroductionTitle),
          _buildText(data.instruction),
          _buildDivider(),
          _buildTag(gm.lectureAuthorIntroductionTitle),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MySizes.s_8),
            child: loadImage(
              data.lecturerHeadUrl,
              width: double.infinity,
            ),
          ),
          _buildText(
            data.lecturerName,
            fontWeight: FontWeight.bold,
            padding: EdgeInsets.only(
              left: MySizes.s_10,
              top: MySizes.s_16,
              right: MySizes.s_10,
              bottom: MySizes.s_12,
            ),
          ),
          _buildText(data.lecturerInstruction),
          _buildDivider(),
          data.partNum > 2
              ? _buildTag(
                  gm.lectureCourseListTitle,
                  padding: EdgeInsets.only(
                    top: MySizes.s_18,
                    bottom: MySizes.s_14,
                  ),
                )
              : EmptyWidget(),
        ],
      ),
    );
  }

  Widget _buildPartList(GmLocalizations gm) {
    if (data.partNum > 2) {
      List<LecturePart> list = data.parts;
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          LecturePart part = list[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => tabController?.index = 1,
            child: Container(
              height: MySizes.s_60,
              margin: EdgeInsets.only(
                left: MySizes.s_8,
                right: MySizes.s_20,
                bottom: MySizes.s_10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  loadImage(
                    part.partHeadUrl,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(MySizes.s_4),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: MySizes.s_15),
                          child: Text(
                            part.partName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.c_878778,
                              fontSize: MyFontSizes.s_12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: MySizes.s_1,
                          height: MySizes.s_8,
                          color: MyColors.c_878778,
                          margin: EdgeInsets.symmetric(horizontal: MySizes.s_8),
                        ),
                        Image(image: MyImages.ic_lecture_part),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MySizes.s_3,
                            right: MySizes.s_10,
                          ),
                          child: Text(
                            "${part.subjectNum}${gm.lecturePartUnitTitle}",
                            style: TextStyle(
                              color: MyColors.c_878778,
                              fontSize: MyFontSizes.s_12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "part ${part.partNo}",
                    style: TextStyle(
                      color: MyColors.c_ffa2b1,
                      fontSize: MyFontSizes.s_12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }, childCount: list?.length ?? 0),
      );
    } else {
      return SliverToBoxAdapter();
    }
  }

  Widget _buildBottom(GmLocalizations gm) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topLeft,
        child: _buildTag(
          gm.lectureCourseDetailTitle,
          padding: EdgeInsets.only(
            top: MySizes.s_20,
            bottom: MySizes.s_18,
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    String contentImg = data.content;
    if (contentImg != null && contentImg.isNotEmpty) {
      List<String> list;
      if (contentImg.contains(",")) {
        list = contentImg.split(",");
      } else {
        list = [contentImg];
      }
      return SliverList(
        delegate: SliverChildListDelegate(
          list.map((e) => loadImage(e)).toList(),
        ),
      );
    } else {
      return SliverToBoxAdapter();
    }
  }

  Widget _buildTag(
    String text, {
    EdgeInsetsGeometry padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: MySizes.s_18),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image(image: MyImages.ic_lecture_tag),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: MyFontSizes.s_12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(
    String text, {
    FontWeight fontWeight,
    EdgeInsetsGeometry padding,
  }) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: MySizes.s_10,
            right: MySizes.s_10,
            bottom: MySizes.s_20,
          ),
      child: Text(
        text,
        style: TextStyle(
          color: MyColors.c_878778,
          fontSize: MyFontSizes.s_12,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
      child: Divider(
        height: MySizes.s_1,
        color: MyColors.c_c1c1c1,
      ),
    );
  }
}

class _CourseWidget extends StatelessWidget {
  final String id;
  final LectureDetail lectureDetail;

  const _CourseWidget(this.id, this.lectureDetail, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget<Course>.listSeparated(
      enablePullUp: false,
      keepAlive: true,
      onRefreshLoading: (pageIndex) =>
          NetManager(context).getLectureCourseList(id: id),
      listItemBuilder: (context, index, data) {
        return CourseItemWidget(
          data,
          lectureDetail.partNum,
          onTap: () {},
        );
      },
      listSeparatorBuilder: (context, index, data) {
        return Divider(
          color: MyColors.c_e5e5e5,
          height: MySizes.s_1,
        );
      },
    );
  }
}

class _CommentWidget extends StatelessWidget {
  final String id;

  const _CommentWidget(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget<CourseComment>.listSeparated(
      keepAlive: true,
      onRefreshLoading: (pageIndex) => NetManager(context)
          .getLectureCommentList(id: id, pageIndex: pageIndex),
      listItemBuilder: (context, index, data) {
        return CourseCommentWidget(data);
      },
      listSeparatorBuilder: (context, index, data) {
        return Divider(
          color: MyColors.c_e5e5e5,
          height: MySizes.s_1,
        );
      },
    );
  }
}
