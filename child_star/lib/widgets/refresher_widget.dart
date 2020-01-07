import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/widgets/common_widget.dart';
import 'package:child_star/widgets/future_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef OnRefreshLoading<T> = Future<PageList<T>> Function(num pageIndex);

typedef RefreshedChildWidgetBuilder<T> = Widget Function(
    BuildContext context, List<T> data);

typedef ListedWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T data);

class SmartRefresherWidget<T> extends StatefulWidget {
  final OnRefreshLoading<T> onRefreshLoading;
  final RefreshedChildWidgetBuilder<T> builder;
  final ListedWidgetBuilder<T> listItemBuilder;
  final ListedWidgetBuilder<T> listSeparatorBuilder;
  final double itemExtent;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final GestureTapCallback onErrorRetryTap;
  final bool keepAlive;
  final bool isShowNoData;

  SmartRefresherWidget({
    Key key,
    @required this.onRefreshLoading,
    @required this.builder,
    this.enablePullUp: true,
    this.enablePullDown: true,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
    this.keepAlive = false,
    this.isShowNoData = false,
  })  : listItemBuilder = null,
        listSeparatorBuilder = null,
        itemExtent = null,
        super(key: key);

  SmartRefresherWidget.list({
    Key key,
    @required this.onRefreshLoading,
    @required this.listItemBuilder,
    this.itemExtent,
    this.enablePullUp: true,
    this.enablePullDown: true,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
    this.keepAlive = false,
    this.isShowNoData = true,
  })  : builder = null,
        listSeparatorBuilder = null,
        super(key: key);

  SmartRefresherWidget.listSeparated({
    Key key,
    @required this.onRefreshLoading,
    @required this.listItemBuilder,
    @required this.listSeparatorBuilder,
    this.itemExtent,
    this.enablePullUp: true,
    this.enablePullDown: true,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
    this.keepAlive = false,
    this.isShowNoData = true,
  })  : builder = null,
        super(key: key);

  @override
  SmartRefresherWidgetState createState() => SmartRefresherWidgetState<T>(
        onRefreshLoading,
        builder,
        listItemBuilder,
        listSeparatorBuilder,
        itemExtent,
        enablePullUp,
        enablePullDown,
        onRefresh,
        onLoading,
        onErrorRetryTap,
        keepAlive,
        isShowNoData,
      );
}

class SmartRefresherWidgetState<T> extends State<SmartRefresherWidget>
    with AutomaticKeepAliveClientMixin {
  final OnRefreshLoading<T> onRefreshLoading;
  final RefreshedChildWidgetBuilder<T> builder;
  final ListedWidgetBuilder<T> listItemBuilder;
  final ListedWidgetBuilder<T> listSeparatorBuilder;
  final double itemExtent;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final GestureTapCallback onErrorRetryTap;
  final bool keepAlive;
  final bool isShowNoData;

  Future<PageList<T>> _future;
  RefreshController _refreshController = RefreshController();
  var _pageIndex;
  List<T> _list;

  SmartRefresherWidgetState(
    this.onRefreshLoading,
    this.builder,
    this.listItemBuilder,
    this.listSeparatorBuilder,
    this.itemExtent,
    this.enablePullUp,
    this.enablePullDown,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
    this.keepAlive,
    this.isShowNoData,
  );

  List<T> get data => _list;

  @override
  bool get wantKeepAlive => keepAlive;

  @override
  void initState() {
    super.initState();
    initFuture();
  }

  initFuture() {
    _pageIndex = PAGE_INDEX;
    _future = onRefreshLoading(_pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilderWidget<PageList<T>>(
      future: _future,
      onErrorRetryTap: () {
        initFuture();
        if (onErrorRetryTap != null) {
          onErrorRetryTap();
        }
        setState(() {});
      },
      builder: (BuildContext context, AsyncSnapshot<PageList<T>> snapshot) {
        _list = snapshot.data.resultList;
        return isShowNoData && (_list == null || _list.isEmpty)
            ? _buildNoData()
            : SmartRefresher(
                controller: _refreshController,
                enablePullUp: enablePullUp,
                enablePullDown: enablePullDown,
                onRefresh: () {
                  pullDownOnRefresh();
                  if (onRefresh != null) {
                    onRefresh();
                  }
                },
                onLoading: () {
                  pullUpOnLoading();
                  if (onLoading != null) {
                    onLoading();
                  }
                },
                child: listSeparatorBuilder != null
                    ? _buildSeparatedListView()
                    : listItemBuilder != null ? _buildListView() : _buildView(),
              );
      },
    );
  }

  Widget _buildView() {
    return builder(context, _list);
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _list?.length ?? 0,
      shrinkWrap: itemExtent ?? true,
      itemExtent: itemExtent,
      itemBuilder: (context, index) =>
          listItemBuilder(context, index, _list[index]),
    );
  }

  Widget _buildSeparatedListView() {
    return ListView.separated(
      itemCount: _list?.length ?? 0,
      shrinkWrap: itemExtent ?? true,
      itemBuilder: (context, index) =>
          listItemBuilder(context, index, _list[index]),
      separatorBuilder: (context, index) =>
          listSeparatorBuilder(context, index, _list[index]),
    );
  }

  Widget _buildNoData() {
    return NoDataWidget();
  }

  pullDownOnRefresh() async {
    try {
      _pageIndex = PAGE_INDEX;
      PageList<T> pageList = await onRefreshLoading(_pageIndex);
      List<T> resultList = pageList.resultList;
      _list?.clear();
      if (resultList != null && resultList.isNotEmpty) {
        _list?.addAll(pageList.resultList);
      } else {}
      if (mounted) {
        setState(() {});
      }
      _refreshController.refreshCompleted(resetFooterState: true);
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  pullUpOnLoading() async {
    try {
      PageList<T> pageList = await onRefreshLoading(++_pageIndex);
      List<T> resultList = pageList.resultList;
      if (resultList != null && resultList.isNotEmpty) {
        _list?.addAll(pageList.resultList);
        if (mounted) {
          setState(() {});
        }
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    } catch (e) {
      _refreshController.loadFailed();
      _pageIndex--;
    }
  }
}
