import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/Net.dart';
import 'package:flutter_demo/common/route_config.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/models/repo.dart';
import 'package:flutter_demo/states/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var page = 1;
  var repos = List<Repo>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: RaisedButton(
            child: Text(GmLocalizations.of(context).login),
            onPressed: () {
              Navigator.of(context).pushNamed(ROUTE_LOGIN);
            }),
      );
    } else {
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("下拉刷新");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松开加载更多");
            } else {
              body = Text("无更多数据...");
            }
            return Container(
              height: 55,
              child: Center(
                child: body,
              ),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: () => _onRefresh(context),
        onLoading: () => _loading(context),
        child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(repos[index].name),
          ),
          itemCount: repos.length,
        ),
      );
    }
  }

  void _onRefresh(BuildContext context) async {
    page = 1;
    var data = await Net(context).getRepos(
        refresh: true,
        queryParameters: {'page': page, 'page_size': 20}).catchError((onError) {
      _refreshController.loadFailed();
    });
    if (data != null) {
      _refreshController.loadComplete();
      setState(() {
        repos.addAll(data);
      });
    } else {
      _refreshController.loadNoData();
    }
  }

  void _loading(BuildContext context) async {
    var data = await Net(context).getRepos(refresh: false, queryParameters: {
      'page': ++page,
      'page_size': 20
    }).catchError((onError) {
      _refreshController.loadFailed();
    });
    if (data != null) {
      _refreshController.loadComplete();
      setState(() {
        repos.addAll(data);
      });
    } else {
      _refreshController.loadNoData();
    }
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
