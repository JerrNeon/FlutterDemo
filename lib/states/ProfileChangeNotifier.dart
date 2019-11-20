import 'package:flutter/material.dart';
import 'package:flutter_demo/common/global.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/models/profile.dart';

///Provider包来实现跨组件状态共享
///登录用户信息、APP主题信息、APP语言信息
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  //App是否登录（如果有用户信息，则证明登录过）
  bool get isLogin => user != null;

  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

///主题状态在用户更换APP主题时更新、通知其依赖项
class ThemeModel extends ProfileChangeNotifier {
  //获取当前主题，如果未设置主题，则使用默认蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);

  //主题改变后，通知依赖项，新主题会立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

///当APP语言选为跟随系统（Auto）时，在系通语言改变时，APP语言会更新；
///当用户在APP中选定了具体语言时（美国英语或中文简体），则APP便会一直使用用户选定的语言，不会再随系统语言而变。
class LocaleModel extends ProfileChangeNotifier {
  //获取当前用户的App语言配置Locale类，如果未null，则语言跟随系统改变
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  //获取当前Locale的字符串标识
  String get locale => _profile.locale;

  //用户改变App语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
