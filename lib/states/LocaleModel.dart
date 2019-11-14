import 'package:flutter/material.dart';

import 'ProfileChangeNotifier.dart';

///当APP语言选为跟随系统（Auto）时，在系通语言改变时，APP语言会更新；
///当用户在APP中选定了具体语言时（美国英语或中文简体），则APP便会一直使用用户选定的语言，不会再随系统语言而变。
class LocaleModel extends ProfileChangeNotifier {
  //获取当前用户的App语言配置Locale类，如果未null，则语言跟随系统改变
  Locale getLocale() {
    if (profile.locale == null) return null;
    var t = profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  //获取当前Locale的字符串标识
  String get locale => profile.locale;

  //用户改变App语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != profile.locale) {
      profile.locale = locale;
      notifyListeners();
    }
  }
}
