import 'dart:convert';

import 'package:child_star/common/Net.dart';
import 'package:child_star/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

///应用入口信息初始化
class Global {
  static const PROFILE_KEY = "profile";
  static SharedPreferences _preferences; //SP
  static Profile profile = Profile(); //保存在SP中的信息

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    var profileStr = _preferences.getString(PROFILE_KEY);
    if (profileStr != null) {
      try {
        profile = Profile.fromJson(jsonDecode(profileStr));
      } catch (e) {
        print(e);
      }
    }

    Net.init();
  }

  // 持久化Profile信息
  static saveProfile() {
    _preferences.setString(PROFILE_KEY, jsonEncode(profile.toJson()));
  }
}
