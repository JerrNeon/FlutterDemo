import 'package:child_star/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySystems {
  ///白底黑字黑色图标
  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, //Android底部navigationBar背景颜色
    systemNavigationBarDividerColor: null,
    statusBarColor: Colors.white, //Android状态栏背景颜色
    systemNavigationBarIconBrightness:
        Brightness.light, //Android底部navigationBar图标颜色(light：灰色,dark：黑色)
    statusBarIconBrightness: Brightness.dark, //Android状态栏图标颜色(light：白色,dark：黑色)
    statusBarBrightness: Brightness.dark, //IOS状态栏图标颜色(light：白色,dark：黑色)
  );

  ///黑底白字白色图标
  static const SystemUiOverlayStyle light = SystemUiOverlayStyle.light;

  ///透明
  static const SystemUiOverlayStyle transparent = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: null,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  );

  ///隐藏[Scaffold]的[AppBar] (Scaffold如果不设置AppBar的话，widget中的内容会显示到状态栏区域)
  static PreferredSize get noAppBarPreferredSize {
    return PreferredSize(
      preferredSize: Size.fromHeight(ScreenUtils.topSafeHeight),
      child: SafeArea(
        top: true,
        child: Offstage(),
      ),
    );
  }
}
