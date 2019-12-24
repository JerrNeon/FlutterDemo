import 'dart:convert';

import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static const _KEY_PROFILE = "profile"; //用户信息
  static const _KEY_NEWS_HISTORY = "news_history"; //资讯搜索历史
  static const _KEY_LECTURE_HISTORY = "lecture_history"; //讲堂搜索历史

  static SharedPreferences _preferences; //SP

  ///初始化
  static Future<Profile> init() async {
    _preferences = await SharedPreferences.getInstance();
    var profileStr = _preferences.getString(_KEY_PROFILE);
    Profile profile = Profile();
    if (profileStr != null) {
      try {
        profile = Profile.fromJson(jsonDecode(profileStr));
      } catch (e) {
        LogUtils.e(e);
      }
    }
    return profile;
  }

  /// 持久化Profile信息
  static saveProfile(Profile profile) {
    if (_preferences != null) {
      _preferences.setString(_KEY_PROFILE, jsonEncode(profile.toJson()));
    }
  }

  static List<Tag> getNewsHistoryList() {
    List<Tag> list = [];
    if (_preferences != null) {
      var strList = _preferences.getStringList(_KEY_NEWS_HISTORY);
      if (strList != null && strList.isNotEmpty) {
        try {
          list = strList
              .map(
                (e) => Tag.fromJson(jsonDecode(e)),
              )
              .toList();
        } catch (e) {
          LogUtils.e(e);
        }
      }
    }
    return list;
  }

  static setNewsHistoryList(List<Tag> list) {
    if (_preferences != null && list != null && list.isNotEmpty) {
      _preferences.setStringList(
          _KEY_NEWS_HISTORY,
          list
              .map(
                (e) => jsonEncode(e.toJson()),
              )
              .toList());
    }
  }

  static removeNewsHistoryList() {
    if (_preferences != null && _preferences.containsKey(_KEY_NEWS_HISTORY)) {
      _preferences.remove(_KEY_NEWS_HISTORY);
    }
  }

  static List<String> getLectureHistoryList() {
    List<String> list = [];
    if (_preferences != null) {
      var strList = _preferences.getStringList(_KEY_LECTURE_HISTORY);
      if (strList != null && strList.isNotEmpty) {
        list = strList;
      }
    }
    return list;
  }

  static setLectureHistoryList(List<String> list) {
    if (_preferences != null && list != null && list.isNotEmpty) {
      _preferences.setStringList(_KEY_LECTURE_HISTORY, list);
    }
  }

  static removeLectureHistoryList() {
    if (_preferences != null &&
        _preferences.containsKey(_KEY_LECTURE_HISTORY)) {
      _preferences.remove(_KEY_LECTURE_HISTORY);
    }
  }
}
