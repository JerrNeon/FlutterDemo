import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = MySizes.s_48;

class AppBarWidget extends StatelessWidget {
  final String title;
  final bool isShowDivider;
  final VoidCallback onPressed;
  final Widget action;

  AppBarWidget(
    this.title, {
    this.isShowDivider = false,
    this.onPressed,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: isShowDivider ? kAppBarHeight + 1 : kAppBarHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: MyColors.c_a4a4a4,
                  ),
                  onPressed: onPressed ?? () => Navigator.of(context).pop()),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MySizes.s_10),
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.c_777777, fontSize: MyFontSizes.s_16),
                  ),
                ),
              ),
              action ?? EmptyWidget(width: MySizes.s_40),
            ],
          ),
          Divider(
            height: isShowDivider ? MySizes.s_1 : 0,
            color: MyColors.c_e9e9e9,
          ),
        ],
      ),
    );
  }
}

class AppBarWidget2 extends PreferredSize {
  final String title;
  final bool isShowDivider;
  final VoidCallback onPressed;
  final Widget action;

  AppBarWidget2(
    this.title, {
    Key key,
    this.isShowDivider = false,
    this.onPressed,
    this.action,
  }) : super(
          key: key,
          preferredSize:
              Size.fromHeight(isShowDivider ? MySizes.s_49 : MySizes.s_48),
          child: null,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: MyColors.c_a4a4a4,
                    ),
                    onPressed: onPressed ?? () => Navigator.of(context).pop()),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: MySizes.s_10),
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors.c_777777, fontSize: MyFontSizes.s_16),
                    ),
                  ),
                ),
                action ?? EmptyWidget(width: MySizes.s_40),
              ],
            ),
            Divider(
              height: isShowDivider ? MySizes.s_1 : 0,
              color: MyColors.c_e9e9e9,
            ),
          ],
        ),
      ),
    );
  }
}
