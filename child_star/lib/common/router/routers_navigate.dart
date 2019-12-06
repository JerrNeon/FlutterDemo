import 'package:child_star/common/router/irouters_navigate.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import 'routers.dart';

class RoutersNavigate extends IRoutersNavigate {
  // 单例公开访问点
  factory RoutersNavigate() => _routersNavigateInstance();

  //静态私有成员，没有初始化
  static RoutersNavigate _instance;

  //私有构造函数
  RoutersNavigate._();

  // 静态、同步、私有访问点
  static RoutersNavigate _routersNavigateInstance() {
    if (_instance == null) {
      _instance = RoutersNavigate._();
    }
    return _instance;
  }

  @override
  navigateToMain(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.root,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToHomeSearch(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.home_search,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToH5(BuildContext context, String url) {
    Routers.router.navigateTo(
      context,
      Routers.h5 + "?url=$url",
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToNewDetail(BuildContext context, String newId) {
    Routers.router.navigateTo(
      context,
      Routers.home_new_detail + "?id=$newId",
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
