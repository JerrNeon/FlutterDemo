import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthorPage extends StatefulWidget {
  final String authorId;

  const AuthorPage(this.authorId, {Key key}) : super(key: key);

  @override
  _AuthorPageState createState() => _AuthorPageState(authorId);
}

class _AuthorPageState extends State<AuthorPage> {
  final String id;
  Future<Author> _future;
  Future<PageList<News>> _newsfuture;

  _AuthorPageState(this.id);

  @override
  void initState() {
    super.initState();
    NetManager netManager = NetManager(context);
    _future = netManager.getAuthorDetail(id);
    _newsfuture = netManager.getAuthorNewsList(id);
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            AppBarWidget(gm.authorTitle),
            Expanded(
              child: FutureBuilderWidget<Author>(
                future: _future,
                builder: (context, snapShot) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      _buildBody(gm, snapShot.data),
                      _buildList(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(GmLocalizations gm, Author data) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PaddingWidget(
                bottom: MySizes.s_30,
                child: loadImage(data.backgroundUrl),
              ),
              Stack(
                children: <Widget>[
                  loadImage(
                    data.headUrl,
                    width: MySizes.s_60,
                    height: MySizes.s_60,
                    shape: BoxShape.circle,
                  ),
                  Positioned(
                    right: -MySizes.s_2,
                    bottom: -MySizes.s_2,
                    child: Image(image: MyImages.ic_newdetail_authenticate),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MySizes.s_10),
          Text(
            data.name,
            style: TextStyle(
              color: MyColors.c_777777,
              fontSize: MyFontSizes.s_16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MySizes.s_6),
          Text(
            gm.authorDescTitle,
            style: TextStyle(
              color: MyColors.c_8b8b8b,
              fontSize: MyFontSizes.s_8,
            ),
          ),
          SizedBox(height: MySizes.s_10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MySizes.s_24),
            child: Text(
              data.introduction,
              style: TextStyle(
                color: MyColors.c_878778,
                fontSize: MyFontSizes.s_12,
              ),
            ),
          ),
          SizedBox(height: MySizes.s_14),
          AuthorFollowWidget(
            authorId: data.id.toString(),
            isConcern: data.isConcern,
          ),
          SizedBox(height: MySizes.s_20),
          Divider(
            color: MyColors.c_e5e5e5,
            height: MySizes.s_1,
          ),
          SizedBox(height: MySizes.s_10),
          Text(
            gm.authorRecommendTitle,
            style: TextStyle(
              color: MyColors.c_777777,
              fontSize: MyFontSizes.s_14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MySizes.s_10),
          Divider(
            color: MyColors.c_e5e5e5,
            height: MySizes.s_1,
          ),
          SizedBox(height: MySizes.s_10),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SliverEmptyFutureBuilderWidget<PageList<News>>(
      future: _newsfuture,
      builder: (context, snapshot) {
        List<News> list = snapshot.data.resultList;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => NewsItemWidget(list[index]),
            childCount: list?.length ?? 0,
          ),
        );
      },
    );
  }
}

class AuthorFollowWidget extends StatefulWidget {
  final String authorId;
  final bool isConcern;

  const AuthorFollowWidget({
    Key key,
    @required this.authorId,
    @required this.isConcern,
  }) : super(key: key);

  @override
  _AuthorFollowWidgetState createState() =>
      _AuthorFollowWidgetState(authorId, isConcern);
}

class _AuthorFollowWidgetState extends State<AuthorFollowWidget> {
  final String authorId;
  bool isConcern;

  _AuthorFollowWidgetState(this.authorId, this.isConcern);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return GestureDetector(
      onTap: () => _doFollow(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: MySizes.s_80,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: MySizes.s_8),
        decoration: BoxDecoration(
          color: isConcern ? MyColors.c_aaaaaa : MyColors.c_febfc9,
          borderRadius: BorderRadius.circular(
            MySizes.s_16,
          ),
        ),
        child: Text(
          isConcern ? gm.authorFollowedTitle : gm.authorUnfollowedTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: MyFontSizes.s_10,
          ),
        ),
      ),
    );
  }

  _doFollow(BuildContext context) async {
    try {
      Result result =
          await NetManager(context).doFollow(authorId: widget.authorId);
      //1：已关注 0：未关注
      isConcern = result.status == 1;
      if (mounted) {
        setState(() {});
      }
      Provider.of<FollowProvider>(context, listen: false)
          .setConcernData(authorId, result.status == 1);
    } catch (e) {
      LogUtils.e(e);
    }
  }
}
