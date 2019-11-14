import 'package:flutter/material.dart';
import 'package:flutter_demo/common/Global.dart';

import 'ProfileChangeNotifier.dart';

///主题状态在用户更换APP主题时更新、通知其依赖项
class ThemeModel extends ProfileChangeNotifier {
  //获取当前主题，如果未设置主题，则使用默认蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == profile.theme, orElse: () => Colors.blue);

  //主题改变后，通知依赖项，新主题会立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      profile.theme = color[500].value;
      notifyListeners();
    }
  }
}
