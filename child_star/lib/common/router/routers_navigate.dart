import 'package:child_star/common/router/irouters_navigate.dart';
import 'package:child_star/utils/route_utils.dart';
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
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToHomeSearch(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.home_search,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToH5(BuildContext context, String url) {
    Routers.router.navigateTo(
      context,
      Routers.h5 + "?url=$url",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToNewDetail(BuildContext context, String newId) {
    Routers.router.navigateTo(
      context,
      Routers.home_new_detail + "?id=$newId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToLogin(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.login,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(
        animationType: RouteAnimation.ANIMATION_SLIDE_BOTTOM_TOP,
      ),
    );
  }

  @override
  Future navigateToRegister(BuildContext context) async {
    return await Routers.router.navigateTo(
      context,
      Routers.register,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToForgetPassword(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.forget_password,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMine(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.mine,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMineSet(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.mine_set,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToExerciseDetail(BuildContext context, String exerciseId) {
    Routers.router.navigateTo(
      context,
      Routers.exercise_detail + "?id=$exerciseId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }
}
