import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class XmlyTypePage extends StatefulWidget {
  final int index;

  const XmlyTypePage({Key key, @required this.index}) : super(key: key);
  @override
  _XmlyTypePageState createState() => _XmlyTypePageState(index);
}

class _XmlyTypePageState extends State<XmlyTypePage>
    with SingleTickerProviderStateMixin {
  final int index;
  TabController _tabController;
  Future<ColumnsPageList> _columnsFuture;

  _XmlyTypePageState(this.index);

  @override
  void initState() {
    _initColumnsFuture();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  _initColumnsFuture() {
    _columnsFuture = XmlyNetManager().getColumnList();
  }

  Future<PageList<Album>> _initAlbumFuture({
    @required int columnId,
    @required num pageIndex,
  }) async {
    ColumnsAlbumPageList columnsAlbumPageList =
        await XmlyNetManager().getAlbumList(id: columnId, page: pageIndex);
    PageList<Album> pageList = PageList();
    pageList.pageNum = columnsAlbumPageList.currentPage;
    pageList.totalNum = columnsAlbumPageList.totalCount;
    pageList.resultList = columnsAlbumPageList.values;
    return pageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      backgroundColor: MyColors.c_f0f0f0,
      body: FutureBuilderWidget<ColumnsPageList>(
        future: _columnsFuture,
        onErrorRetryTap: () {
          if (mounted) {
            _initColumnsFuture();
            setState(() {});
          }
        },
        builder: (context, snapshot) {
          ColumnsPageList pageList = snapshot.data;
          List<Columns> list = pageList?.columns;
          list?.removeWhere((element) =>
              element.id == XmlyData.COLUMN_HOT_ID ||
              element.id == XmlyData.COLUMN_POP_ID);
          _tabController ??= TabController(
              length: list?.length ?? 0, vsync: this, initialIndex: index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: MyColors.c_a4a4a4,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicatorColor: MyColors.c_ffa2b1,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: MySizes.s_3,
                          labelColor: MyColors.c_ffa2b1,
                          labelStyle: TextStyle(
                            fontSize: MyFontSizes.s_15,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelColor: MyColors.c_777777,
                          unselectedLabelStyle: TextStyle(
                            fontSize: MyFontSizes.s_15,
                            fontWeight: FontWeight.bold,
                          ),
                          tabs: list.map((e) => Tab(text: e.title)).toList()),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: list.map((e) => _buildList(e)).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(Columns columns) {
    return SmartRefresherWidget<Album>.listSeparated(
      onRefreshLoading: (pageIndex) =>
          _initAlbumFuture(columnId: columns.id, pageIndex: pageIndex),
      keepAlive: true,
      listItemBuilder: (context, index, album) => XmlyAlbumWidget(data: album),
      listSeparatorBuilder: (context, index, album) =>
          SizedBox(height: MySizes.s_12),
      listPadding: EdgeInsets.only(top: MySizes.s_12),
      isShowNoData: true,
      noDataWidget: XmlyAlbumEmptyWidget(),
    );
  }
}
