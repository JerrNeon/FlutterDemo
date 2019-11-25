import 'package:child_star/common/global.dart';
import 'package:child_star/routes/main_page.dart';
import 'package:child_star/states/profile_notifier.dart';
import 'package:flutter/material.dart';
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
        home: MainPage(),
        color: Colors.white,
        routes: {},
      ),
    );
  }
}
