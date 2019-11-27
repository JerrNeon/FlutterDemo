import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenUtils {

  ///屏幕宽
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.size.width;
  }

  ///屏幕高
  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.size.height;
  }

  ///dpi
  static double get scale {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.devicePixelRatio;
  }

  ///字体缩放比例
  static double get textScaleFactor {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.textScaleFactor;
  }

  ///导航栏高度
  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  ///状态栏高度
  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.padding.top;
  }

  ///底部导航栏高度
  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
    return mediaQuery.padding.bottom;
  }
}
