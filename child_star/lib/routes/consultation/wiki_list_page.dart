import 'dart:convert';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/consultation_widget.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///育儿百科列表界面
class WikiListPage extends StatefulWidget {
  final int index;
  final String title;
  final String tagList;

  const WikiListPage({
    Key key,
    @required this.index,
    @required this.title,
    @required this.tagList,
  }) : super(key: key);

  @override
  _WikiListPageState createState() => _WikiListPageState(
      index, chineseDecode(title), jsonDecode(chineseDecode(tagList)));
}

class _WikiListPageState extends State<WikiListPage>
    with SingleTickerProviderStateMixin {
  final int index;
  final String title;
  final List tagList;

  TabController _tabController;
  List<Tag> _tabList;

  _WikiListPageState(this.index, this.title, this.tagList);

  @override
  void initState() {
    super.initState();
    _tabList = tagList.map((e) => Tag.fromJson(e)).toList();
    _tabController = TabController(
        initialIndex: index, length: _tabList?.length ?? 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        children: <Widget>[
          AppBarWidget(chineseDecode(widget.title)),
          _buildTabBar(),
          Expanded(
            child: _buildTagBarView(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    if (tagList != null && tagList.isNotEmpty) {
      return TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: MyColorsFul.wiki_tag[index % 10],
        indicatorWeight: MySizes.s_3,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: TextStyle(
          fontSize: MyFontSizes.s_15,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: MyColors.c_686868,
        labelColor: MyColorsFul.wiki_tag[index % 10],
        labelStyle: TextStyle(
          fontSize: MyFontSizes.s_15,
          fontWeight: FontWeight.bold,
        ),
        tabs: _tabList
            .map((e) => Tab(
                  text: e.name,
                ))
            .toList(),
      );
    } else {
      return EmptyWidget();
    }
  }

  Widget _buildTagBarView() {
    return TabBarView(
      controller: _tabController,
      children: _tabList.map((e) {
        return SmartRefresherWidget.list(
          keepAlive: true,
          onRefreshLoading: (pageIndex) => NetManager(context).getWikiList(
            tagId: e.id.toString(),
            pageIndex: pageIndex,
          ),
          listItemBuilder: (context, index, data) => WikiItemWidget(data: data),
        );
      }).toList(),
    );
  }
}
