import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeTagListPage extends StatefulWidget {
  @override
  _HomeTagListPageState createState() => _HomeTagListPageState();
}

class _HomeTagListPageState extends State<HomeTagListPage> {
  Future<List<TagList>> _future;
  var parentMap = <String, int>{};
  var itemMap = <int, List<TagListItem>>{};
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  _initFuture() {
    _future = NetManager(context).getTagList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            GmLocalizations.of(context).homeHotTagTitle,
            isShowDivider: true,
          ),
          Expanded(
            child: FutureBuilderWidget<List<TagList>>(
              future: _future,
              onErrorRetryTap: () {
                _initFuture();
                if (mounted) {
                  setState(() {});
                }
              },
              builder: (context, snapshot) {
                List<TagList> tagList = snapshot.data;
                if (tagList != null && tagList.isNotEmpty) {
                  tagList.asMap().forEach((index, e) {
                    parentMap.addAll({e.name: index});
                    itemMap.addAll({index: e.tags});
                  });
                  return Column(
                    children: <Widget>[
                      SizedBox(height: MySizes.s_10),
                      buildTop(tagList),
                      Container(
                        color: MyColors.c_fafafa,
                        height: MySizes.s_4,
                      ),
                      Expanded(
                        child: buildList(),
                      ),
                    ],
                  );
                } else {
                  return NoDataWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTop(List<TagList> list) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: MySizes.s_14,
      childAspectRatio: 3,
      shrinkWrap: true,
      children: list.map((e) {
        return GestureDetector(
          onTap: () {
            _currentIndex = parentMap[e.name];
            setState(() {});
          },
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  e.name,
                  style: TextStyle(
                    color: MyColors.c_636363,
                    fontSize: MyFontSizes.s_15,
                  ),
                ),
                PaddingWidget(
                  top: MySizes.s_6,
                  child: Offstage(
                    offstage: parentMap[e.name] != _currentIndex,
                    child: Container(
                      width: MySizes.s_40,
                      height: MySizes.s_4,
                      decoration: BoxDecoration(
                        color: MyColors.c_ffb6c3,
                        borderRadius: BorderRadius.circular(MySizes.s_12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildList() {
    List<TagListItem> list = itemMap[_currentIndex];
    if (list != null && list.isNotEmpty) {
      return ListView(
        shrinkWrap: true,
        children: list.map((e) {
          return CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                  left: MySizes.s_14,
                  top: MySizes.s_14,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: MySizes.s_5,
                        height: MySizes.s_16,
                        decoration: BoxDecoration(
                          color: MyColors.c_ffb6c3,
                          borderRadius: BorderRadius.circular(MySizes.s_12),
                        ),
                      ),
                      PaddingWidget(
                        left: MySizes.s_6,
                        child: Text(
                          e.name,
                          style: TextStyle(
                            color: MyColors.c_717171,
                            fontSize: MyFontSizes.s_13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: MySizes.s_8,
                  top: MySizes.s_10,
                  right: MySizes.s_14,
                  bottom: MySizes.s_4,
                ),
                sliver: SliverGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: MySizes.s_6,
                  crossAxisSpacing: MySizes.s_6,
                  childAspectRatio: 3,
                  children: (e.tags != null && e.tags.isNotEmpty)
                      ? e.tags.map((tag) {
                          return GestureDetector(
                            onTap: () => RoutersNavigate()
                                .navigateToHomeSearchResultPage(
                                    context, tag.id.toString(), tag.name),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(MySizes.s_12),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(MySizes.s_1),
                                border: Border.all(
                                  color: MyColors.c_dadada,
                                  width: MySizes.s_1,
                                ),
                              ),
                              child: Text(
                                tag.name,
                                style: TextStyle(
                                  color: MyColors.c_636363,
                                  fontSize: MyFontSizes.s_14,
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      : EmptyWidget(),
                ),
              ),
            ],
          );
        }).toList(),
      );
    } else {
      return EmptyWidget();
    }
  }
}
