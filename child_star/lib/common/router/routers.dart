import 'package:child_star/routes/home/home_search_page.dart';
import 'package:child_star/routes/main_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routers {
  static const String root = "/main";
  static const String home_search = "/main/home/search";

  static var router = Router();

  static init() {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      print("route was not found");
      return null;
    });
    router.define(root, handler: mainHandler);
    router.define(home_search, handler: homeSearchHandler);
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
