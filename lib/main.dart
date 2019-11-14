import 'package:flutter/material.dart';

import 'jsp_code/my_app.dart';

///   common	一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
///   i10n	国际化相关的类都在此目录下
///   models	Json文件对应的Dart Model类会在此目录下
///   states	保存APP中需要跨组件共享的状态类
///   routes	存放所有路由页面类
///   widgets	APP内封装的一些Widget组件都在该目录下

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false, //去掉DeBug图标
      home: MyAppWidget(),
    );
  }
}
