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

  @override
  navigateToLogin(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.login,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  Future navigateToRegister(BuildContext context) async {
    return await Routers.router.navigateTo(
      context,
      Routers.register,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToForgetPassword(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.forget_password,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToMine(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.mine,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToMineSet(BuildContext context) {
    Routers.router.navigateTo(
      context,
      Routers.mine_set,
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  navigateToExerciseDetail(BuildContext context, String exerciseId) {
    Routers.router.navigateTo(
      context,
      Routers.exercise_detail + "?id=$exerciseId",
      transition: TransitionType.nativeModal,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
