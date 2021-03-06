import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Tag> _historyList;
  Future<List<Tag>> _future;

  @override
  void initState() {
    super.initState();
    _historyList = SpUtils.getNewsHistoryList();
    _future = NetManager(context).getHotTagList();
  }

  @override
  Widget build(BuildContext context) {
    final gm = GmLocalizations.of(context);
    return Scaffold(
        appBar: MySystems.noAppBarPreferredSize,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HomeSearchWidget(
              controller: _textEditingController,
              onSubmitted: (s) => _search("", s, isSearch: true),
            ),
            _buildHistory(gm),
            _buildHot(gm),
          ],
        ));
  }

  Widget _buildHistory(GmLocalizations gm) {
    if (_historyList.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: MySizes.s_4),
          Container(
            color: MyColors.c_f0f0f0,
            height: MySizes.s_4,
          ),
          SizedBox(height: MySizes.s_12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PaddingWidget(
                left: MySizes.s_14,
                child: Text(
                  gm.homeSearchHistoryTitle,
                  style: TextStyle(
                    color: MyColors.c_777777,
                    fontSize: MyFontSizes.s_12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _clear(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySizes.s_6),
                  child: Image(
                    image: MyImages.ic_homesearch_clear,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MySizes.s_14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MySizes.s_15),
            child: Wrap(
              spacing: MySizes.s_10,
              runSpacing: MySizes.s_14,
              children: _historyList
                  .map((tag) => HomeSearchTagWidget(
                        text: tag.name,
                        onTap: () => _search(
                          tag.id != null ? tag.id.toString() : "",
                          tag.name,
                        ),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(height: MySizes.s_10),
        ],
      );
    } else {
      return EmptyWidget();
    }
  }

  Widget _buildHot(GmLocalizations gm) {
    return EmptyFutureBuilderWidget<List<Tag>>(
      future: _future,
      builder: (context, snapshot) {
        List<Tag> list = snapshot.data;
        if (list != null && list.isNotEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: MyColors.c_f0f0f0,
                height: MySizes.s_4,
              ),
              SizedBox(height: MySizes.s_12),
              PaddingWidget(
                left: MySizes.s_14,
                child: Text(
                  gm.homeSearchHotTitle,
                  style: TextStyle(
                    color: MyColors.c_777777,
                    fontSize: MyFontSizes.s_12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MySizes.s_14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_15),
                child: Wrap(
                  spacing: MySizes.s_10,
                  runSpacing: MySizes.s_14,
                  children: list
                      .map((tag) => HomeSearchTagWidget(
                            text: tag.name,
                            onTap: () => _search(tag.id.toString(), tag.name,
                                isSearch: true),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        } else {
          return EmptyWidget();
        }
      },
    );
  }

  _search(String id, String name, {bool isSearch = false}) {
    if (isSearch) {
      var result = -1;
      if (_historyList.isNotEmpty) {
        result = _historyList.indexWhere((e) => e.name == name);
      }
      if (result == -1) {
        var tag = Tag();
        if (id.isNotEmpty) {
          tag.id = int.tryParse(id);
        }
        tag.name = name;
        _historyList.add(tag);
        if (_historyList.length >= 16) {
          _historyList.removeAt(0);
        }
        if (mounted) {
          setState(() {});
        }
        SpUtils.setNewsHistoryList(_historyList);
      }
    }
    RoutersNavigate().navigateToHomeSearchResultPage(context, id, name);
  }

  _clear() {
    _historyList.clear();
    if (mounted) {
      setState(() {});
    }
    SpUtils.removeNewsHistoryList();
  }
}
