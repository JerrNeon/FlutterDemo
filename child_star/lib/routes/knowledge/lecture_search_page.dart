import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class LectureSearchPage extends StatefulWidget {
  @override
  _LectureSearchPageState createState() => _LectureSearchPageState();
}

class _LectureSearchPageState extends State<LectureSearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _historyList;

  @override
  void initState() {
    super.initState();
    _historyList = SpUtils.getLectureHistoryList();
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
              onSubmitted: (s) => _search(s, isSearch: true),
            ),
            _buildHistory(gm),
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
                  .map((e) => HomeSearchTagWidget(
                        text: e,
                        onTap: () => _search(e),
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

  _search(String name, {isSearch = false}) {
    if (isSearch) {
      var result = -1;
      if (_historyList.isNotEmpty) {
        result = _historyList.indexWhere((e) => e == name);
      }
      if (result == -1) {
        _historyList.add(name);
        if (_historyList.length >= 16) {
          _historyList.removeAt(0);
        }
        if (mounted) {
          setState(() {});
        }
        SpUtils.setLectureHistoryList(_historyList);
      }
    }
    RoutersNavigate().navigateToLectureSearchResultPage(context, name);
  }

  _clear() {
    _historyList.clear();
    if (mounted) {
      setState(() {});
    }
    SpUtils.removeLectureHistoryList();
  }
}
