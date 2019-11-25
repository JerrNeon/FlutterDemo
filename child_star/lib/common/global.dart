import 'dart:convert';

import 'package:child_star/common/Net.dart';
import 'package:child_star/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

///应用入口信息初始化
class Global {
  static const PROFILE_KEY = "profile";
  static SharedPreferences _preferences; //SP
  static Profile profile = Profile(); //保存在SP中的信息

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    String profileStr;
    try {
      profileStr = _preferences.getString(PROFILE_KEY);
    } catch (e) {}
    if (profileStr != null && profileStr.isNotEmpty)
      profile = Profile.fromJson(jsonDecode(profileStr));

    Net.init();
  }

  static void saveProfile() {
    _preferences.setString(PROFILE_KEY, jsonEncode(profile));
  }
}
