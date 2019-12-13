import 'package:child_star/routes/home/h5_page.dart';
import 'package:child_star/routes/home/home_search_page.dart';
import 'package:child_star/routes/home/new_detail_page.dart';
import 'package:child_star/routes/login/forgetpassword_page.dart';
import 'package:child_star/routes/login/login_page.dart';
import 'package:child_star/routes/login/register_page.dart';
import 'package:child_star/routes/main_page.dart';
import 'package:child_star/routes/user/mine_page.dart';
import 'package:child_star/routes/user/mine_set_page.dart';
import 'package:child_star/states/profile_notifier.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Routers {
  static const String root = "/";
  static const String home_search = "/home/search";
  static const String h5 = "/h5";
  static const String home_new_detail = "/home/new_detail";
  static const String login = "/user/login";
  static const String register = "/user/register";
  static const String forget_password = "/user/forget_password";
  static const String mine = "/user/mine";
  static const String mine_set = "/user/mine/set";

  static var router = Router();

  static init() {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      LogUtils.e("route was not found");
      return null;
    });
    router.define(root, handler: mainHandler);
    router.define(home_search, handler: homeSearchHandler);
    router.define(h5, handler: h5Handler);
    router.define(home_new_detail, handler: homeNewDetailHandler);
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
    router.define(forget_password, handler: forgetPasswordHandler);
    router.define(mine, handler: mineHandler);
    router.define(mine_set, handler: mineSetHandler);
  }
}

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MainPage();
});

var homeSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomeSearchPage();
});

var h5Handler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String url = parameters["url"]?.first ?? "";
  return H5Page(url);
});

var homeNewDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return NewDetailPage(id);
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginPage();
});

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RegisterPage();
});

var forgetPasswordHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return ForgetPasswordPage();
});

var mineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return userProvider.isLogin ? MinePage() : LoginPage();
});

var mineSetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MineSetPage();
});
