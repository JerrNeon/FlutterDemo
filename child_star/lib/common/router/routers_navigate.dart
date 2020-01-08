import 'dart:convert';

import 'package:child_star/common/router/irouters_navigate.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/route_utils.dart';
import 'package:child_star/utils/utils_index.dart';
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
  navigateToMain(
    BuildContext context, {
    bool replace = false,
    bool clearStack = false,
  }) {
    return Routers.router.navigateTo(
      context,
      Routers.root,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
      replace: replace,
      clearStack: clearStack,
    );
  }

  @override
  navigateToHomeSearch(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.home_search,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToH5(BuildContext context, String url) {
    return Routers.router.navigateTo(
      context,
      Routers.h5 + "?url=${encodeStringToBase64UrlSafeString(url)}",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToNewDetail(BuildContext context, String newId) {
    return Routers.router.navigateTo(
      context,
      Routers.home_new_detail + "?id=$newId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToLogin(BuildContext context) {
    return Routers.router.navigateTo(
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
    return Routers.router.navigateTo(
      context,
      Routers.forget_password,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMine(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMineSet(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_set,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToExerciseDetail(BuildContext context, String exerciseId) {
    return Routers.router.navigateTo(
      context,
      Routers.exercise_detail + "?id=$exerciseId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToLectureDetail(BuildContext context, String lectureId) {
    return Routers.router.navigateTo(
      context,
      Routers.lecture_detail + "?id=$lectureId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToCourseDetail(BuildContext context, String courseId) {
    return Routers.router.navigateTo(
      context,
      Routers.course_detail + "?id=$courseId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToAuthorPage(BuildContext context, String authorId) {
    return Routers.router.navigateTo(
      context,
      Routers.author_homepage + "?id=$authorId",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToHomeSearchResultPage(BuildContext context, String id, String name) {
    return Routers.router.navigateTo(
      context,
      Routers.home_search_result + "?id=$id&name=${chineseEncode(name)}",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToLectureSearchPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.lecture_search,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToLectureSearchResultPage(BuildContext context, String name) {
    return Routers.router.navigateTo(
      context,
      Routers.lecture_search_result + "?name=${chineseEncode(name)}",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToHomeTagListPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.home_tag_list,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToInquiryPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.consultation_inquiry,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToWikiTagPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.consultation_wiki_tag,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToWikiListPage(
      BuildContext context, int index, String title, List<Tag> tagList) {
    String json = jsonEncode(tagList.map((e) => e.toJson()).toList());
    return Routers.router.navigateTo(
      context,
      Routers.consultation_wiki_list +
          "?index=$index&title=${chineseEncode(title)}&tagList=${chineseEncode(json)}",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMyOrderPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_my_order,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMyCoursePage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_my_course,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMyCollectionPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_my_collection,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMyAttentionPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_my_attention,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToModifyUserInfoPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_modify_userinfo,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToModifyNamePage(BuildContext context, int type) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_modify_name + "?type=$type",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMyBookPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_book,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToMyDownloadPage(BuildContext context) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_download,
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }

  @override
  navigateToDownloadDetailPage(BuildContext context, int type, String path) {
    return Routers.router.navigateTo(
      context,
      Routers.mine_download_detail +
          "?type=$type&path=${encodeStringToBase64UrlSafeString(path)}",
      transition: TransitionType.custom,
      transitionBuilder: RouteAnimation.build(),
    );
  }
}
