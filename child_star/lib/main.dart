import 'package:child_star/common/global.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/routes/main_page.dart';
import 'package:child_star/states/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => Global.init().then((value) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateTitle: (context) => GmLocalizations.of(context).appName,
        //手动指定环境为中文简体
        locale: const Locale("zh", "CN"),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GmLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("zh", "CN"), //中文简体
          Locale("en", "US"), //美国英语
        ],
        home: MainPage(),
        routes: {},
      ),
    );
  }
}
