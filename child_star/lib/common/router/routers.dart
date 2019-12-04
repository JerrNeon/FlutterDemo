import 'package:child_star/routes/home/h5_page.dart';
import 'package:child_star/routes/home/home_search_page.dart';
import 'package:child_star/routes/main_page.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routers {
  static const String root = "/";
  static const String home_search = "/home/search";
  static const String h5 = "/h5";

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
