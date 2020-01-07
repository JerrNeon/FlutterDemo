import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAttentionPage extends StatefulWidget {
  @override
  _MyAttentionPageState createState() => _MyAttentionPageState();
}

class _MyAttentionPageState extends State<MyAttentionPage> {
  final GlobalKey<SmartRefresherWidgetState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: MyColors.c_fafafa,
        child: Column(
          children: <Widget>[
            AppBarWidget(
              gm.mineOrder,
              isShowDivider: true,
            ),
            Expanded(
              child: SmartRefresherWidget<MyAttention>.list(
                key: _globalKey,
                onRefreshLoading: (pageIndex) => NetManager(context)
                    .getMyAttentionList(pageIndex: pageIndex),
                listItemBuilder: (context, index, data) {
                  return GestureDetector(
                      onTap: () => RoutersNavigate().navigateToAuthorPage(
                          context, data.authorId.toString()),
                      behavior: HitTestBehavior.opaque,
                      child: _buildItem(gm, data));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(GmLocalizations gm, MyAttention data) {
    return Container(
      padding: EdgeInsets.only(
        left: MySizes.s_8,
        top: MySizes.s_8,
        right: MySizes.s_8,
        bottom: MySizes.s_10,
      ),
      child: Row(
        children: <Widget>[
          loadImage(
            data.authorHeadUrl,
            width: MySizes.s_52,
            shape: BoxShape.circle,
          ),
          SizedBox(width: MySizes.s_10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.authorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColors.c_777777,
                    fontSize: MyFontSizes.s_13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MySizes.s_4),
                Text(
                  data.authorIntroduction,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColors.c_999999,
                    fontSize: MyFontSizes.s_10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: MySizes.s_10),
          GestureDetector(
            onTap: () => _cancelAttention(data),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_18,
                vertical: MySizes.s_6,
              ),
              decoration: BoxDecoration(
                color: MyColors.c_afafaf,
                borderRadius: BorderRadius.circular(MySizes.s_12),
              ),
              child: Text(
                gm.myAttentionStatusTitle,
                style: TextStyle(
                  color: MyColors.c_f4f4f4,
                  fontSize: MyFontSizes.s_10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _cancelAttention(MyAttention data) async {
    try {
      await NetManager(context).doFollow(authorId: data.authorId.toString());
      _globalKey.currentState.pullDownOnRefresh();
    } catch (e) {
      LogUtils.e(e);
    }
  }
}
