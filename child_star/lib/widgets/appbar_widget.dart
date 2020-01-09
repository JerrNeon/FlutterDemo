import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = MySizes.s_48;

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title; //标题
  final bool isShowDivider; //是否显示底部分割线
  final double dividerHeight; //分割线高度
  final Widget leading; //leading(默认返回键)
  final Color backgroundColor; //背景色
  final VoidCallback onPressed; //默认leading点击事件
  final Widget action; //action

  AppBarWidget(
    this.title, {
    Key key,
    this.isShowDivider = false,
    this.dividerHeight = MySizes.s_1,
    this.leading,
    this.backgroundColor = Colors.white,
    this.onPressed,
    this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(
        isShowDivider ? kAppBarHeight + dividerHeight : kAppBarHeight,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                leading ??
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: MyColors.c_a4a4a4,
                      ),
                      onPressed: onPressed ?? () => Navigator.of(context).pop(),
                    ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: MySizes.s_10),
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_16,
                      ),
                    ),
                  ),
                ),
                action ?? EmptyWidget(width: MySizes.s_40),
              ],
            ),
            Divider(
              height: isShowDivider ? dividerHeight : 0,
              color: MyColors.c_e9e9e9,
            ),
          ],
        ),
      ),
    );
  }
}
