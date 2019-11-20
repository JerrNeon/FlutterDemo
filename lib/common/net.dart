import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/cache_object.dart';
import 'package:flutter_demo/common/global.dart';
import 'package:flutter_demo/models/index.dart';

///网络请求
class Net {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Net([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;

  static Dio dio = new Dio(BaseOptions(
    baseUrl: "https://api.github.com/",
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {
    //添加缓存拦截器
    dio.interceptors.add(Global.netCache);
    if (!Global.isRelease) {
      dio.interceptors.add(LogInterceptor());
    }
    //设置用户token
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    //在调试模式下需要抓包，所以我们需要使用代理，并禁用https证书校验
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.200.38.96:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  ///登录接口
  Future<User> login(String login, String pwd) async {
    String basic = 'Basic ' + base64.encode(utf8.encode("$login:$pwd"));
    var r = await dio.get(
      "users/$login",
      options: _options.merge(
          headers: {HttpHeaders.authorizationHeader: basic},
          extra: {KEY_NOCACHE: true}), //禁用缓存
    );
    //登录成功后更新公共头（authorization），此后所有的请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    Global.netCache.cache.clear();
    //更新profile中的token信息
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  ///获取用户项目列表
  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({KEY_REFRESH: true, KEY_LIST: true});
    }
    _options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    var r = await dio.get<List>(
      "user/repos",
      queryParameters: queryParameters,
      options: _options,
    );
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }
}
