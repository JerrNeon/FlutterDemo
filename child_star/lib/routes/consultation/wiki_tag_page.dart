import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WikiTagPage extends StatefulWidget {
  @override
  _WikiTagPageState createState() => _WikiTagPageState();
}

class _WikiTagPageState extends State<WikiTagPage> {
  Future<List<WikiTagList>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  _initFuture() {
    _future = NetManager(context).getWikiTagList();
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        children: <Widget>[
          AppBarWidget(gm.wikiTagTitle, isShowDivider: true),
          SizedBox(height: MySizes.s_13),
          SearchWidget(text: gm.wikiTagSearchHint),
          SizedBox(height: MySizes.s_13),
          Expanded(
            child: FutureBuilderWidget<List<WikiTagList>>(
              future: _future,
              builder: (context, snapshot) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: AdWidget(),
                    ),
                    _buildList(snapshot.data),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: MySizes.s_14),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<WikiTagList> list) {
    if (list != null && list.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            WikiTagList tag = list[index];
            List<Tag> tagList = tag.tags;
            return Column(
              children: <Widget>[
                SizedBox(height: MySizes.s_26),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: MySizes.s_14,
                      height: MySizes.s_3,
                      decoration: BoxDecoration(
                        color: MyColorsFul.wiki_tag[index % 10],
                        borderRadius: BorderRadius.circular(MySizes.s_2),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: MySizes.s_14),
                      child: Text(
                        tag.name,
                        style: TextStyle(
                          color: MyColorsFul.wiki_tag[index % 10],
                          fontSize: MyFontSizes.s_15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MySizes.s_14,
                      height: MySizes.s_3,
                      decoration: BoxDecoration(
                        color: MyColorsFul.wiki_tag[index % 10],
                        borderRadius: BorderRadius.circular(MySizes.s_2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MySizes.s_24),
                _buildItemList(index, tag, tagList),
              ],
            );
          },
          childCount: list.length,
        ),
      );
    } else {
      return SliverToBoxAdapter();
    }
  }

  Widget _buildItemList(int parentIndex, WikiTagList tag, List<Tag> list) {
    if (list != null && list.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: MySizes.s_4),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: MySizes.s_24,
          crossAxisSpacing: MySizes.s_16,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 105 / 46,
          shrinkWrap: true,
          children: list.asMap().keys.map((index) {
            return GestureDetector(
              onTap: () => RoutersNavigate().navigateToWikiListPage(
                context,
                parentIndex,
                index,
                tag.name,
                tag.tags,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColorsFul.wiki_tag_item[parentIndex % 10],
                  borderRadius: BorderRadius.circular(MySizes.s_2),
                ),
                child: Text(
                  list[index].name,
                  style: TextStyle(
                    color: MyColors.c_686868,
                    fontSize: MyFontSizes.s_14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return EmptyWidget();
    }
  }
}
