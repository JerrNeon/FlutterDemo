import 'dart:ui';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:flutter/services.dart';

class StatusBarUtils {
  ///设置状态栏颜色
  static setColor(Color statusBarColor) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: statusBarColor,
    ));
  }

  ///设置状态栏白底黑字
  static setDark() {
    SystemChrome.setSystemUIOverlayStyle(MySystems.dark);
  }

  ///设置状态栏黑底白字
  static setLight() {
    SystemChrome.setSystemUIOverlayStyle(MySystems.light);
  }

  ///设置状态栏透明
  static setTransparent() {
    SystemChrome.setSystemUIOverlayStyle(MySystems.transparent);
  }

  ///隐藏状态栏
  static hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  ///隐藏操作栏
  static hideNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  ///显示状态栏和操作栏
  static showBar() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  ///隐藏状态栏和操作栏
  static hideBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  ///恢复状态栏设置到上一次的样式
  static restoreSystemUIOverlays() {
    SystemChrome.restoreSystemUIOverlays();
  }

  ///设置竖屏
  static portrait() {
    // 如果是全屏就切换竖屏
    AutoOrientation.portraitAutoMode();
    //显示状态栏，与底部虚拟操作按钮
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  ///设置横屏
  static landscape() {
    AutoOrientation.landscapeAutoMode();
    //关闭状态栏，与底部虚拟操作按钮
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
