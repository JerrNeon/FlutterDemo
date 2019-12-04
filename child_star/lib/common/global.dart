import 'dart:convert';

import 'package:child_star/common/net/net.dart';
import 'package:child_star/common/router/routers.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

///应用入口信息初始化
class Global {
  static const PROFILE_KEY = "profile";
  static SharedPreferences _preferences; //SP
  static Profile profile = Profile(); //保存在SP中的信息

  static var logger = Logger(); //日志打印
  static var loggerNoStack = Logger(
    //日志打印(不打印所在日志关联的方法信息)
    printer: PrettyPrinter(methodCount: 0),
  );

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    var profileStr = _preferences.getString(PROFILE_KEY);
    if (profileStr != null) {
      try {
        profile = Profile.fromJson(jsonDecode(profileStr));
      } catch (e) {
        LogUtils.e(e);
      }
    }

    //Release不打印日志
    if (isRelease) {
      Logger.level = Level.nothing;
    }

    Net.init();
    Routers.init();
  }

  // 持久化Profile信息
  static saveProfile() {
    _preferences.setString(PROFILE_KEY, jsonEncode(profile.toJson()));
  }
}
