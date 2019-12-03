import 'package:child_star/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySystems {
  ///白底黑字黑色图标
  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: null,
    statusBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
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
