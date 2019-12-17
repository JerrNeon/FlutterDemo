import 'package:child_star/common/net/net_config.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/models_index.dart';
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
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final GestureTapCallback onErrorRetryTap;

  SmartRefresherWidget({
    Key key,
    @required this.onRefreshLoading,
    @required this.builder,
    this.enablePullUp: true,
    this.enablePullDown: true,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
  })  : listItemBuilder = null,
        super(key: key);

  SmartRefresherWidget.list({
    Key key,
    @required this.onRefreshLoading,
    @required this.listItemBuilder,
    this.enablePullUp: true,
    this.enablePullDown: true,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
  })  : builder = null,
        super(key: key);

  @override
  _SmartRefresherWidgetState createState() => _SmartRefresherWidgetState<T>(
        onRefreshLoading,
        builder,
        listItemBuilder,
        enablePullUp,
        enablePullDown,
        onRefresh,
        onLoading,
        onErrorRetryTap,
      );
}

class _SmartRefresherWidgetState<T> extends State<SmartRefresherWidget> {
  final OnRefreshLoading<T> onRefreshLoading;
  final RefreshedChildWidgetBuilder<T> builder;
  final ListedWidgetBuilder<T> listItemBuilder;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final GestureTapCallback onErrorRetryTap;
  Future<PageList<T>> _future;
  RefreshController _refreshController = RefreshController();
  var _pageIndex;
  List<T> list;

  _SmartRefresherWidgetState(
    this.onRefreshLoading,
    this.builder,
    this.listItemBuilder,
    this.enablePullUp,
    this.enablePullDown,
    this.onRefresh,
    this.onLoading,
    this.onErrorRetryTap,
  );

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
        list = snapshot.data.resultList;
        return list != null && list.isNotEmpty
            ? SmartRefresher(
                controller: _refreshController,
                enablePullUp: enablePullUp,
                enablePullDown: enablePullDown,
                onRefresh: () {
                  _onRefresh();
                  if (onRefresh != null) {
                    onRefresh();
                  }
                },
                onLoading: () {
                  _onLoading();
                  if (onLoading != null) {
                    onLoading();
                  }
                },
                child: listItemBuilder != null
                    ? _buildListView()
                    : builder(context, list),
              )
            : _buildNoData();
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          listItemBuilder(context, index, list[index]),
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Text(
        "no data",
        style: TextStyle(
          color: MyColors.c_686868,
          fontSize: MyFontSizes.s_14,
        ),
      ),
    );
  }

  _onRefresh() async {
    try {
      _pageIndex = PAGE_INDEX;
      PageList<T> pageList = await onRefreshLoading(_pageIndex);
      List<T> resultList = pageList.resultList;
      list?.clear();
      if (resultList != null && resultList.isNotEmpty) {
        list?.addAll(pageList.resultList);
      } else {}
      if (mounted) {
        setState(() {});
      }
      _refreshController.refreshCompleted(resetFooterState: true);
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  _onLoading() async {
    try {
      PageList<T> pageList = await onRefreshLoading(++_pageIndex);
      List<T> resultList = pageList.resultList;
      if (resultList != null && resultList.isNotEmpty) {
        list?.addAll(pageList.resultList);
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
