import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LectureSearchResultPage extends StatefulWidget {
  final String name;

  const LectureSearchResultPage(this.name, {Key key}) : super(key: key);

  @override
  _LectureSearchResultPageState createState() =>
      _LectureSearchResultPageState(chineseDecode(name));
}

class _LectureSearchResultPageState extends State<LectureSearchResultPage> {
  final String name;

  _LectureSearchResultPageState(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            GmLocalizations.of(context).homeSearchResultTitle,
            isShowDivider: true,
          ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SmartRefresherWidget<Lecture>.list(
      onRefreshLoading: (pageIndex) => NetManager(context).getLectureSearchList(
        pageIndex: pageIndex,
        title: name,
      ),
      listItemBuilder: (context, index, data) {
        return Padding(
          padding: const EdgeInsets.only(
            left: MySizes.s_4,
            top: MySizes.s_4,
            right: MySizes.s_4,
          ),
          child: LectureItemWidget(data: data),
        );
      },
    );
  }
}
