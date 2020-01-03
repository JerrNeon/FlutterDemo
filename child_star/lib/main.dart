import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/routes/splash_page.dart';
import 'package:child_star/states/states_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/resource_index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) {
    runApp(MyApp());
    //设置状态栏颜色(白底黑字黑色图标)
    SystemChrome.setSystemUIOverlayStyle(MySystems.dark);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: RefreshConfiguration(
        headerBuilder: () => ClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: MyColors.c_ffa2b1, //主色，决定导航栏颜色
              accentColor: MyColors.c_ffa2b1, //次级色，决定大多数Widget的颜色，如进度条、开关等。
              scaffoldBackgroundColor: Colors.white, //作为Scaffold基础的Material默认颜色
              //解决TextField提示语hintText不居中的问题
              textTheme: TextTheme(
                subhead: TextStyle(
                  textBaseline: TextBaseline.alphabetic,
                ),
              )),
          //不显示debug图标
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => GmLocalizations.of(context).appName,
          onGenerateRoute: Routers.router.generator,
          //手动指定环境为中文简体
          locale: const Locale("zh", "CN"),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizations.delegate,
            GmCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("zh", "CN"), //中文简体
            Locale("en", "US"), //美国英语
          ],
          home: SplashPage(),
        ),
      ),
    );
  }
}
