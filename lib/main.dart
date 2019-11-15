import 'package:flutter/material.dart';
import 'package:flutter_demo/common/global.dart';
import 'package:flutter_demo/common/route_config.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/states/LocaleModel.dart';
import 'package:flutter_demo/states/ThemeModel.dart';
import 'package:flutter_demo/states/UserModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'jsp_code/my_app.dart';
import 'routes/Language_page.dart';
import 'routes/home_page.dart';
import 'routes/login_page.dart';
import 'routes/theme_change_page.dart';

///   common	一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
///   i10n	国际化相关的类都在此目录下
///   models	Json文件对应的Dart Model类会在此目录下
///   states	保存APP中需要跨组件共享的状态类
///   routes	存放所有路由页面类
///   widgets	APP内封装的一些Widget组件都在该目录下

//初始化完成后才会加载UI
void main() => Global.init().then((e) => runApp(new MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel())
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder: (BuildContext context,
          ThemeModel themeModel, LocaleModel localeModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: themeModel.theme),
          onGenerateTitle: (context) {
            return GmLocalizations.of(context).title;
          },
          home: HomeRoute(),
          locale: localeModel.getLocale(),
          //我们只支持美国英语和中文简体
          supportedLocales: [
            const Locale("en", "US"), // 美国英语
            const Locale("zh", "CN"), // 中文简体
          ],
          localizationsDelegates: [
            //本地化的代理类
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizationsDelegate()
          ],
          localeResolutionCallback: (_locale, supportedLocales) {
            //如果已经选定语言，则不跟随系统
            if (localeModel.getLocale() != null) {
              return localeModel.getLocale();
            } else {
              Locale locale;
              //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
              //则默认使用美国英语
              if (supportedLocales.contains(_locale)) {
                locale = _locale;
              } else {
                locale = Locale("en", "US");
              }
              return locale;
            }
          },
          // 注册命名路由表
          routes: <String, WidgetBuilder>{
            ROUTE_LOGIN: (context) => LoginRoute(),
            ROUTE_THEMES: (context) => ThemeChangeRoute(),
            ROUTE_LANGUAGE: (context) => LanguageRoute(),
          },
        );
      }),
    );
  }

  Widget _myAppWidgetDemo() {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false, //去掉DeBug图标
      home: MyAppWidget(),
    );
  }
}
