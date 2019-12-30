import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCoursePage extends StatefulWidget {
  @override
  _MyCoursePageState createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    _tabList ??= [
      gm.myCoursePayTitle,
      gm.myCourseFreeTitle,
    ];
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: MyColors.c_fafafa,
        child: Column(
          children: <Widget>[
            AppBarWidget(
              gm.mineCourse,
              isShowDivider: true,
            ),
            buildTabBar(),
            Expanded(
              child: buildTabBarView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: MyColors.c_ffa2b1,
      indicatorWeight: MySizes.s_2,
      labelColor: MyColors.c_ffa2b1,
      labelStyle: TextStyle(fontSize: MyFontSizes.s_12),
      unselectedLabelColor: MyColors.c_777777,
      unselectedLabelStyle: TextStyle(fontSize: MyFontSizes.s_12),
      tabs: _tabList
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
    );
  }

  Widget buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        _buildList(1),
        _buildList(2),
      ],
    );
  }

  ///type	否	int	1：收费课程；2：免费课程；
  Widget _buildList(int type) {
    return SmartRefresherWidget<MyCourse>.list(
      keepAlive: true,
      onRefreshLoading: (pageIndex) =>
          NetManager(context).getMyCourseList(type: type, pageIndex: pageIndex),
      listItemBuilder: (context, index, data) {
        return GestureDetector(
            onTap: () => RoutersNavigate()
                .navigateToLectureDetail(context, data.id.toString()),
            behavior: HitTestBehavior.opaque,
            child: buildItem(data));
      },
    );
  }

  Widget buildItem(MyCourse data) {
    return Container(
      padding: EdgeInsets.only(
        left: MySizes.s_16,
        top: MySizes.s_8,
        right: MySizes.s_16,
        bottom: MySizes.s_16,
      ),
      child: Row(
        children: <Widget>[
          loadImage(
            data.headUrl,
            width: MySizes.s_118,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(MySizes.s_3),
          ),
          SizedBox(width: MySizes.s_16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColors.c_8c8c8c,
                    fontSize: MyFontSizes.s_14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MySizes.s_4),
                Text(
                  data.descr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColors.c_8c8c8c,
                    fontSize: MyFontSizes.s_14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
