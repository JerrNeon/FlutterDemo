import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/common/Net.dart';
import 'package:flutter_demo/common/route_config.dart';
import 'package:flutter_demo/common/utils.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/states/ProfileChangeNotifier.dart';
import 'package:flutter_demo/widgets/item_home_repo.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  Future<List<Repo>> _repos;

  @override
  void initState() {
    _repos = _initRepos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: IndexedStack(
        children: <Widget>[_buildBody()],
      ),
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
      return Center(
        child: FutureBuilder(
            future: _repos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return GestureDetector(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                        child: Text(
                          "加载失败，请重试！",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                      behavior: HitTestBehavior.opaque, //使padding点击区域生效
                      onTap: () {
                        setState(() {});
                      });
                } else {
                  return CupertinoScrollbar(
                      child: MySmartRefresher(snapshot.data));
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      );
    }
  }

  Future<List<Repo>> _initRepos() async {
    print("init: ");
    return await Net(context).getRepos(
      refresh: true,
      queryParameters: {'page': 1, 'page_size': 20},
    );
  }
}

class MySmartRefresher extends StatefulWidget {
  final List<Repo> repos;

  MySmartRefresher(this.repos);

  @override
  _MySmartRefresherState createState() => _MySmartRefresherState(repos);
}

class _MySmartRefresherState extends State<MySmartRefresher> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  var page = 1;
  final List<Repo> repos;

  _MySmartRefresherState(this.repos);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: _buildFooter(),
      controller: _refreshController,
      onRefresh: () => _onRefresh(),
      onLoading: () => _loading(),
      child: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
          child: RepoItem(repos[index]),
          onTap: () =>
              Navigator.of(context).pushNamed(ROUTE_MY_APP_WIDGET_DEMO),
        ),
        itemCount: repos.length,
      ),
    );
  }

  Widget _buildFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("上拉加载更多");
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
    );
  }

  void _onRefresh() async {
    print("_onRefresh: ");
    page = 1;
    List<Repo> data;
    try {
      data = await Net(context).getRepos(
        refresh: true,
        queryParameters: {'page': page, 'page_size': 20},
      );
    } catch (e) {
      _refreshController.refreshFailed();
    }
    if (data != null && data.isNotEmpty) {
      repos.clear();
      repos.addAll(data);
    }
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  void _loading() async {
    print("_loading: ");
    List<Repo> data;
    try {
      data = await Net(context).getRepos(
        refresh: false,
        queryParameters: {'page': ++page, 'page_size': 20},
      );
    } catch (e) {
      _refreshController.loadFailed();
    }
    if (data != null && data.isNotEmpty) {
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
                      ? gmAvatar(value.user.avatar_url, width: 80)
                      : Image.asset(
                          "imgs/avatar-default.png",
                          width: 80,
                        ),
                ),
              ),
              Text(
                value.isLogin
                    ? value.user.name
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
