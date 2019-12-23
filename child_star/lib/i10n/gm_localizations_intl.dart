import 'package:child_star/i10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GmLocalizations {
  static Future<GmLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((value) {
      Intl.defaultLocale = localeName;
      return new GmLocalizations();
    });
  }

  static GmLocalizations of(BuildContext context) {
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  static const LocalizationsDelegate<GmLocalizations> delegate =
      _GmLocalizationsDelegate();

  String get appName {
    return Intl.message('child_star', name: 'appName', locale: "zh");
  }

  String get homeTitle {
    return Intl.message('首页', name: 'homeTitle');
  }

  String get homeExitMessage {
    return Intl.message('再按一次退出程序', name: 'homeExitMessage');
  }

  String get knowledgeTitle {
    return Intl.message('知识', name: 'knowledgeTitle');
  }

  String get exerciseTitle {
    return Intl.message('活动', name: 'exerciseTitle');
  }

  String get consultationTitle {
    return Intl.message('在线咨询', name: 'consultationTitle');
  }

  String get searchHintTitle {
    return Intl.message("你想找的这里都有...", name: "searchHintTitle");
  }

  String get homeNewTitle {
    return Intl.message("最新", name: "homeNewTitle");
  }

  String get homeAttentionTitle {
    return Intl.message("关注", name: "homeAttentionTitle");
  }

  String get homeAttentionRecommendTitle {
    return Intl.message("为您推荐母婴达人", name: "homeAttentionRecommendTitle");
  }

  String get homeCommunityTitle {
    return Intl.message("社区", name: "homeCommunityTitle");
  }

  String get loadFailureTitle {
    return Intl.message("加载失败,点击重试!", name: "loadFailureTitle");
  }

  String get newDetailUnFollowTitle {
    return Intl.message("关注", name: "newDetailUnFollowTitle");
  }

  String get newDetailFollowTitle {
    return Intl.message("已关注", name: "newDetailFollowTitle");
  }

  String get newDetailDownloadTitle {
    return Intl.message("缓存", name: "newDetailDownloadTitle");
  }

  String get newDetailReadingNumTitle {
    return Intl.message("阅读量", name: "newDetailReadingNumTitle");
  }

  String get newDetailRelateVideoTitle {
    return Intl.message("相关视频", name: "newDetailRelateVideoTitle");
  }

  String get newDetailRelateAudioTitle {
    return Intl.message("相关音频", name: "newDetailRelateAudioTitle");
  }

  String get newDetailRelateArticleTitle {
    return Intl.message("相关图文", name: "newDetailRelateArticleTitle");
  }

  String get loginWelcomeTitle {
    return Intl.message("欢迎来到好妈咪星球", name: "loginWelcomeTitle");
  }

  String get loginMobileHintTitle {
    return Intl.message("请输入手机号码", name: "loginMobileHintTitle");
  }

  String get loginMobileErrorTitle {
    return Intl.message("手机号格式不正确", name: "loginMobileErrorTitle");
  }

  String get loginPasswordHintTitle {
    return Intl.message("请输入8-16位密码", name: "loginPasswordHintTitle");
  }

  String get loginPasswordErrorTitle {
    return Intl.message("密码格式不正确", name: "loginPasswordErrorTitle");
  }

  String get registerTitle {
    return Intl.message("注册", name: "registerTitle");
  }

  String get loginForgetPasswordTitle {
    return Intl.message("忘记密码？", name: "loginForgetPasswordTitle");
  }

  String get registerGetVerificationCodeTitle {
    return Intl.message("获取验证码", name: "registerGetVerificationCodeTitle");
  }

  String get registerVerificationCodeHintTitle {
    return Intl.message("验证码", name: "registerVerificationCodeHintTitle");
  }

  String get registerVerificationCodeErrorTitle {
    return Intl.message("验证码格式不正确", name: "registerVerificationCodeErrorTitle");
  }

  String get registerVerificationCodeSendSuccess {
    return Intl.message("验证码发送成功", name: "registerVerificationCodeSendSuccess");
  }

  String get loginSubmitTitle {
    return Intl.message("确认", name: "loginSubmitTitle");
  }

  String get mineTitle {
    return Intl.message("个人中心", name: "mineTitle");
  }

  String get mineFocus {
    return Intl.message("我的关注", name: "mineFocus");
  }

  String get mineScoreUnit {
    return Intl.message("颗", name: "mineScoreUnit");
  }

  String get mineScore {
    return Intl.message("积分规则", name: "mineScore");
  }

  String get minePointUnit {
    return Intl.message("个", name: "minePointUnit");
  }

  String get minePoint {
    return Intl.message("充值知识点", name: "minePoint");
  }

  String get mineEquity {
    return Intl.message("我的权益", name: "mineEquity");
  }

  String get mineCourse {
    return Intl.message("我的课程", name: "mineCourse");
  }

  String get mineMall {
    return Intl.message("福利商城", name: "mineMall");
  }

  String get mineOrder {
    return Intl.message("我的订单", name: "mineOrder");
  }

  String get mineBook {
    return Intl.message("绘本书籍", name: "mineBook");
  }

  String get mineDownload {
    return Intl.message("离线缓存", name: "mineDownload");
  }

  String get mineCollection {
    return Intl.message("我的收藏", name: "mineCollection");
  }

  String get mineSetTitle {
    return Intl.message("用户设置", name: "mineSetTitle");
  }

  String get mineSetPush {
    return Intl.message("消息推送设置", name: "mineSetPush");
  }

  String get mineSetGeneral {
    return Intl.message("通用", name: "mineSetGeneral");
  }

  String get mineSetAboutUs {
    return Intl.message("关于我们", name: "mineSetAboutUs");
  }

  String get mineSetFeedback {
    return Intl.message("意见反馈", name: "mineSetFeedback");
  }

  String get mineSetLogout {
    return Intl.message("登出", name: "mineSetLogout");
  }

  String get mineSetLogoutDialogContent {
    return Intl.message("确认退出？", name: "mineSetLogoutDialogContent");
  }

  String get mineSetLogoutSuccess {
    return Intl.message("退出成功", name: "mineSetLogoutSuccess");
  }

  String get dialogTipsTitle {
    return Intl.message("温馨提示", name: "dialogTipsTitle");
  }

  String get dialogNagativeTitle {
    return Intl.message("取消", name: "dialogNagativeTitle");
  }

  String get dialogPositiveTitle {
    return Intl.message("确认", name: "dialogPositiveTitle");
  }

  String get exerciseAllTitle {
    return Intl.message("全部活动", name: "exerciseAllTitle");
  }

  String get exerciseBookDescribeTitle {
    return Intl.message("绘本介绍", name: "exerciseBookDescribeTitle");
  }

  String get consultationSearchHint {
    return Intl.message("查找育儿资料", name: "consultationSearchHint");
  }

  String get consultationEncyclopediaTitle {
    return Intl.message("育儿百科", name: "consultationEncyclopediaTitle");
  }

  String get consultationQuestionTitle {
    return Intl.message("精选问答", name: "consultationQuestionTitle");
  }

  String get consultationBrowseNumTitle {
    return Intl.message("次浏览", name: "consultationBrowseNumTitle");
  }

  String get lectureBuyNumberTitle {
    return Intl.message("购课人数:", name: "lectureBuyNumberTitle");
  }

  String get lectureRecommendNumberTitle {
    return Intl.message("推荐:", name: "lectureRecommendNumberTitle");
  }

  String get lectureSalePriceTitle {
    return Intl.message("课程售价:", name: "lectureSalePriceTitle");
  }

  String get lectureFreePriceTitle {
    return Intl.message("VIP免费课程", name: "lectureFreePriceTitle");
  }

  String get lectureIntroductionTitle {
    return Intl.message("介绍", name: "lectureIntroductionTitle");
  }

  String get lectureCourseTitle {
    return Intl.message("课程", name: "lectureCourseTitle");
  }

  String get lectureCommentTitle {
    return Intl.message("交流", name: "lectureCommentTitle");
  }

  String get lectureCourseIntroductionTitle {
    return Intl.message("课程介绍", name: "lectureCourseIntroductionTitle");
  }

  String get lectureAuthorIntroductionTitle {
    return Intl.message("讲师介绍", name: "lectureAuthorIntroductionTitle");
  }

  String get lectureCourseListTitle {
    return Intl.message("课程列表", name: "lectureCourseListTitle");
  }

  String get lectureCourseDetailTitle {
    return Intl.message("课程详情", name: "lectureCourseDetailTitle");
  }

  String get lecturePartUnitTitle {
    return Intl.message("篇", name: "lecturePartUnitTitle");
  }

  String get lectureBuyToast {
    return Intl.message("请先购买课程", name: "lectureBuyToast");
  }

  String get courseRelateTitle {
    return Intl.message("系列课程", name: "courseRelateTitle");
  }

  String get courseCommentTitle {
    return Intl.message("课程评论", name: "courseCommentTitle");
  }

  String get courseCommentNoDataText {
    return Intl.message("暂无评论~", name: "courseCommentNoDataText");
  }
}

class _GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  const _GmLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["zh", "en"].contains(locale.languageCode);
  }

  @override
  Future<GmLocalizations> load(Locale locale) {
    return GmLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<GmLocalizations> old) {
    return false;
  }
}
