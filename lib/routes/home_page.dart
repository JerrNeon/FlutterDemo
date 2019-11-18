import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/Net.dart';
import 'package:flutter_demo/common/route_config.dart';
import 'package:flutter_demo/common/utils.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/states/UserModel.dart';
import 'package:flutter_demo/widgets/item_home_repo.dart';
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
  var isEmpty = false;
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
    if (isEmpty) {
      return Center(
        child: Text(
          "no data",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      );
    } else {
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
            itemBuilder: (context, index) => RepoItem(repos[index]),
            itemCount: repos.length,
          ),
        );
      }
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
      repos.addAll(data);
      if (mounted) {
        setState(() {
          isEmpty = false;
        });
      }
      _refreshController.loadComplete();
    } else {
      setState(() {
        isEmpty = true;
      });
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
      repos.addAll(data);
      if (mounted) {
        setState(() {});
      }
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //移除顶部padding
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),
            Expanded(child: _buildMenus()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel value, Widget child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClipOval(
                  // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                  child: value.isLogin
                      ? gmAvatar(value.profile.user.avatar_url, width: 80)
                      : Image.asset(
                          "imgs/avatar-default.png",
                          width: 80,
                        ),
                ),
              ),
              Text(
                value.isLogin
                    ? value.profile.user.name
                    : GmLocalizations.of(context).login,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (!value.isLogin) {
            Navigator.of(context).pushNamed(ROUTE_LOGIN);
          }
        },
      );
    });
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () => Navigator.of(context).pushNamed(ROUTE_THEMES),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => Navigator.of(context).pushNamed(ROUTE_LANGUAGE),
            ),
            if (value.isLogin)
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text(gm.logout),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(gm.logoutTip),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(gm.cancel)),
                            FlatButton(
                              onPressed: () {
                                value.user = null;
                                Navigator.of(context).pop();
                              },
                              child: Text(gm.yes),
                            ),
                          ],
                        );
                      });
                },
              ),
          ],
        );
      },
    );
  }
}
