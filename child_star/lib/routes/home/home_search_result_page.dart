import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeSearchResultPage extends StatefulWidget {
  final String id;
  final String name;

  const HomeSearchResultPage({Key key, this.id, this.name}) : super(key: key);

  @override
  _HomeSearchResultPageState createState() =>
      _HomeSearchResultPageState(id, chineseDecode(name));
}

class _HomeSearchResultPageState extends State<HomeSearchResultPage> {
  final String id;
  final String name;

  _HomeSearchResultPageState(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      backgroundColor: MyColors.c_f0f0f0,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            GmLocalizations.of(context).homeSearchResultTitle,
            isShowDivider: true,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: MySizes.s_5,
                top: MySizes.s_5,
                right: MySizes.s_5,
              ),
              child: _buildList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SmartRefresherWidget(
      isShowNoData: true,
      onRefreshLoading: (pageIndex) => id.isNotEmpty
          ? NetManager(context).getNewsSearchList(
              pageIndex: pageIndex,
              tagIds: id.toString(),
            )
          : NetManager(context).getNewsSearchList(
              pageIndex: pageIndex,
              title: name,
            ),
      builder: (context, data) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemBuilder: (context, index) {
            return HomeNewsItemWidget(data: data[index]);
          },
          itemCount: data?.length ?? 0,
          mainAxisSpacing: MySizes.s_5,
          crossAxisSpacing: MySizes.s_5,
        );
      },
    );
  }
}
