import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo/models/cacheConfig.dart';
import 'package:flutter_demo/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_object.dart';
import 'net.dart';

///管理APP的全局变量

//提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

//状态信息SP保存key
const profileKey = "profile";

class Global {
  static SharedPreferences _prefs;
  static Profile profile = new Profile();

  //网络缓存对象
  static NetCache netCache = NetCache();

  //可选主题列表
  static List<MaterialColor> get themes => _themes;

  //是否为Release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在App启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString(profileKey);
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    //如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
    Net.init();
  }

  //持久化Profile信息
  static saveProfile() =>
      _prefs.setString(profileKey, jsonEncode(profile.toJson()));
}
