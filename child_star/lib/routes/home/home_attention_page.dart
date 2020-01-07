import 'dart:math';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/pagelist.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAttentionPage extends StatefulWidget {
  @override
  _HomeAttentionPageState createState() => _HomeAttentionPageState();
}

class _HomeAttentionPageState extends State<HomeAttentionPage>
    with AutomaticKeepAliveClientMixin {
  Future<PageList<Author>> _recommendFuture;
  int _length = 0;
  final GlobalKey<SmartRefresherWidgetState> _globalKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _recommendFuture = NetManager(context).getRecommendAuthorNewsList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: MyColors.c_f0f0f0,
        child: Column(
          children: <Widget>[
            SearchWidget(),
            Expanded(
              child: SmartRefresherWidget<Author>(
                key: _globalKey,
                enablePullUp: _length > 3,
                onRefreshLoading: (pageIndex) => NetManager(context)
                    .getAttentionAuthorNewsList(pageIndex: pageIndex),
                builder: (context, data) => _buildBody(data),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(List<Author> list) {
    _length = list?.length ?? 0;
    if (_length > 3) {
      return ListView.builder(
        itemBuilder: (context, index) =>
            _buildItem(list[index]..isConcern = true),
        itemCount: list.length,
        shrinkWrap: true,
      );
    } else {
      return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildItem(
                list[index]..isConcern = true,
              ),
              childCount: list.length,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: MySizes.s_4,
              vertical: MySizes.s_12,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: MyColors.c_4a4a4a,
                      height: MySizes.s_1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MySizes.s_8),
                    child: Text(
                      GmLocalizations.of(context).homeAttentionRecommendTitle,
                      style: TextStyle(
                        color: MyColors.c_787878,
                        fontSize: MyFontSizes.s_12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: MyColors.c_4a4a4a,
                      height: MySizes.s_1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverEmptyFutureBuilderWidget<PageList<Author>>(
            future: _recommendFuture,
            builder: (context, snapshot) {
              List<Author> authorList = snapshot.data.resultList;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildItem(
                    authorList[index]..isConcern = false,
                  ),
                  childCount: authorList.length,
                ),
              );
            },
          ),
        ],
      );
    }
  }

  Widget _buildItem(Author data) {
    List<News> list = data.infoList;
    return PaddingWidget(
      bottom: MySizes.s_10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //作者信息
          Container(
            width: MySizes.s_130,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Image(image: MyImages.ic_attention_bg),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => RoutersNavigate()
                          .navigateToAuthorPage(context, data.id.toString()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: MySizes.s_12),
                          Stack(
                            children: <Widget>[
                              loadImage(
                                data.headUrl,
                                width: MySizes.s_55,
                                height: MySizes.s_55,
                                shape: BoxShape.circle,
                              ),
                              Positioned(
                                right: -MySizes.s_2,
                                bottom: -MySizes.s_2,
                                child: Image(
                                    image: MyImages.ic_newdetail_authenticate),
                              ),
                            ],
                          ),
                          SizedBox(height: MySizes.s_12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: MySizes.s_4,
                            ),
                            child: Text(
                              data.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: MyColors.c_686868,
                                fontSize: MyFontSizes.s_12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: MySizes.s_6),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: MySizes.s_4,
                            ),
                            child: Text(
                              data.introduction,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: MyColors.c_686868,
                                fontSize: MyFontSizes.s_12,
                              ),
                            ),
                          ),
                          SizedBox(height: MySizes.s_20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              PaddingWidget(
                                right: MySizes.s_2,
                                child: Text(
                                  data.fans.toString(),
                                  style: TextStyle(
                                    color: MyColors.c_787878,
                                    fontSize: MyFontSizes.s_10,
                                  ),
                                ),
                              ),
                              Image(image: MyImages.ic_attention_fans),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: MySizes.s_4,
                                ),
                                child: VerticalDividerWidget(
                                    color: MyColors.c_929292,
                                    height: MySizes.s_10),
                              ),
                              Image(image: MyImages.ic_attention_article),
                              PaddingWidget(
                                left: MySizes.s_2,
                                child: Text(
                                  data.articles.toString(),
                                  style: TextStyle(
                                    color: MyColors.c_787878,
                                    fontSize: MyFontSizes.s_10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MySizes.s_16),
                    Consumer<FollowProvider>(
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () => _doFollow(data),
                          child: Image(
                              image: MyImagesMultiple.attention_status[
                                  data.id.toString() == value.authorId
                                      ? value.isConcern
                                      : data.isConcern]),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          //资讯
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: list.map((news) {
                return GestureDetector(
                  onTap: () => RoutersNavigate()
                      .navigateToNewDetail(context, news.id.toString()),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MySizes.s_4,
                      right: MySizes.s_4,
                    ),
                    child: Stack(
                      children: <Widget>[
                        loadImage(
                          news.headUrl,
                          width: double.infinity,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(MySizes.s_4),
                        ),
                        Positioned(
                          bottom: MySizes.s_8,
                          left: MySizes.s_14,
                          right: MySizes.s_14,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(MySizes.s_5),
                                decoration: BoxDecoration(
                                  color:
                                      MyColorsFul.home_tag[Random().nextInt(6)],
                                  borderRadius:
                                      BorderRadius.circular(MySizes.s_11),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: MySizes.s_1,
                                  ),
                                ),
                                child: Text(
                                  news.innerWord,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MyFontSizes.s_12),
                                ),
                              ),
                              SizedBox(height: MySizes.s_8),
                              Text(
                                news.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MyFontSizes.s_12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _doFollow(Author data) async {
    try {
      await NetManager(context).doFollow(authorId: data.id.toString());
      Provider.of<FollowProvider>(context).reset();
      _globalKey.currentState.pullDownOnRefresh();
    } catch (e) {
      LogUtils.e(e);
    }
  }
}
