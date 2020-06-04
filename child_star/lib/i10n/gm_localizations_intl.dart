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

  String get searchEmptyToast {
    return Intl.message("搜索内容不能为空", name: "searchEmptyToast");
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

  String get newDetailDownloadCompleteToast {
    return Intl.message("下载完成", name: "newDetailDownloadCompleteToast");
  }

  String get newDetailDownloadVideoToast {
    return Intl.message("您已经缓存过此视频", name: "newDetailDownloadVideoToast");
  }

  String get newDetailDownloadAudioToast {
    return Intl.message("您已经缓存过此音频", name: "newDetailDownloadAudioToast");
  }

  String get downloadDeleteConfirmTitle {
    return Intl.message("确认删除？", name: "downloadDeleteConfirmTitle");
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

  String get mineBookDetail {
    return Intl.message("书籍详情", name: "mineBookDetail");
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

  String get exerciseBookDownloadHint {
    return Intl.message("下载完成请至我的书籍里观看绘本", name: "exerciseBookDownloadHint");
  }

  String get exerciseBookDownload {
    return Intl.message("下载书籍", name: "exerciseBookDownload");
  }

  String get exerciseBookDownloading {
    return Intl.message("下载中", name: "exerciseBookDownloading");
  }

  String get exerciseBookRead {
    return Intl.message("阅读书籍", name: "exerciseBookRead");
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

  String get authorTitle {
    return Intl.message("个人主页", name: "authorTitle");
  }

  String get authorDescTitle {
    return Intl.message("作者简介", name: "authorDescTitle");
  }

  String get authorUnfollowedTitle {
    return Intl.message("关注", name: "authorUnfollowedTitle");
  }

  String get authorFollowedTitle {
    return Intl.message("取消关注", name: "authorFollowedTitle");
  }

  String get authorRecommendTitle {
    return Intl.message("内容推荐", name: "authorRecommendTitle");
  }

  String get homeSearchHistoryTitle {
    return Intl.message("历史记录", name: "homeSearchHistoryTitle");
  }

  String get homeSearchHotTitle {
    return Intl.message("热门搜索", name: "homeSearchHotTitle");
  }

  String get homeSearchResultTitle {
    return Intl.message("搜索结果", name: "homeSearchResultTitle");
  }

  String get homeHotTagTitle {
    return Intl.message("热门标签", name: "homeHotTagTitle");
  }

  String get splashSkipTitle {
    return Intl.message("跳过", name: "splashSkipTitle");
  }

  String get inquiryTitle {
    return Intl.message("在线问诊", name: "inquiryTitle");
  }

  String get inquiryTab1Title {
    return Intl.message("全科在线咨询", name: "inquiryTab1Title");
  }

  String get inquiryTab2Title {
    return Intl.message("儿童私人在线专属健康顾问", name: "inquiryTab2Title");
  }

  String get inquiryTipsTitle {
    return Intl.message("# 本服务由第三方专业平台提供，有任何疑问请直接咨询第三方平台 #",
        name: "inquiryTipsTitle");
  }

  String get inquiryDialogContent {
    return Intl.message("VIP会员（推广期6元/年）\n可以享受免费在线咨询\n马上加入吧！",
        name: "inquiryDialogContent");
  }

  String get inquiryDialogPositive {
    return Intl.message("购买会员", name: "inquiryDialogPositive");
  }

  String get inquiryDialogNegative {
    return Intl.message("继续前往", name: "inquiryDialogNegative");
  }

  String get wikiTagTitle {
    return Intl.message("育儿百科", name: "wikiTagTitle");
  }

  String get wikiTagSearchHint {
    return Intl.message("查找育儿资料", name: "wikiTagSearchHint");
  }

  String get myOrderNoTitle {
    return Intl.message("订单编号", name: "myOrderNoTitle");
  }

  String get myOrderNumber1Title {
    return Intl.message("共", name: "myOrderNumber1Title");
  }

  String get myOrderNumber2Title {
    return Intl.message("件商品", name: "myOrderNumber2Title");
  }

  String get myOrderPriceTitle {
    return Intl.message("实付：", name: "myOrderPriceTitle");
  }

  String get chinesePriceTitle {
    return Intl.message("¥", name: "chinesePriceTitle");
  }

  String get myOrderTypeCourseTitle {
    return Intl.message("课程", name: "myOrderTypeCourseTitle");
  }

  String get myOrderTypeBookTitle {
    return Intl.message("书籍", name: "myOrderTypeBookTitle");
  }

  String get myOrderTypeVipTitle {
    return Intl.message("VIP", name: "myOrderTypeVipTitle");
  }

  String get myOrderTypeRechargeTitle {
    return Intl.message("充值", name: "myOrderTypeRechargeTitle");
  }

  String get myCoursePayTitle {
    return Intl.message("付费课程", name: "myCoursePayTitle");
  }

  String get myCourseFreeTitle {
    return Intl.message("免费课程", name: "myCourseFreeTitle");
  }

  String get myCollectionNewsTitle {
    return Intl.message("资讯", name: "myCollectionNewsTitle");
  }

  String get myCollectionLectureTitle {
    return Intl.message("讲堂", name: "myCollectionLectureTitle");
  }

  String get myAttentionStatusTitle {
    return Intl.message("已关注", name: "myAttentionStatusTitle");
  }

  String get modifyUserInfoTitle {
    return Intl.message("编辑个人资料", name: "modifyUserInfoTitle");
  }

  String get modifyUserInfoAvatar {
    return Intl.message("点击更换头像", name: "modifyUserInfoAvatar");
  }

  String get modifyUserInfoDialogCamera {
    return Intl.message("拍一张", name: "modifyUserInfoDialogCamera");
  }

  String get modifyUserInfoDialogAlbum {
    return Intl.message("相册选择", name: "modifyUserInfoDialogAlbum");
  }

  String get modifyUserInfoDialogCancel {
    return Intl.message("取消", name: "modifyUserInfoDialogCancel");
  }

  String get modifyUserInfoNickName {
    return Intl.message("昵称", name: "modifyUserInfoNickName");
  }

  String get modifyUserInfoSex {
    return Intl.message("性别", name: "modifyUserInfoSex");
  }

  String get modifyUserInfoAddress {
    return Intl.message("常住地", name: "modifyUserInfoAddress");
  }

  String get modifyUserInfoSignature {
    return Intl.message("个性签名", name: "modifyUserInfoSignature");
  }

  String get modifyNickNameTitle {
    return Intl.message("修改昵称", name: "modifyNickNameTitle");
  }

  String get modifyNickNameError {
    return Intl.message("昵称格式不正确", name: "modifyNickNameError");
  }

  String get modifyNickNameLimit {
    return Intl.message("最多16个字，只允许包含字母、数字、下划线和点", name: "modifyNickNameLimit");
  }

  String get modifyNickNameSubmit {
    return Intl.message("确认", name: "modifyNickNameSubmit");
  }

  String get modifySignatureTitle {
    return Intl.message("修改个性签名", name: "modifySignatureTitle");
  }

  String get modifySignatureError {
    return Intl.message("个性签名不能为空", name: "modifySignatureError");
  }

  String get modifySignatureLimit {
    return Intl.message("最多20个字", name: "modifySignatureLimit");
  }

  String get modifySuccessToast {
    return Intl.message("修改成功", name: "modifySuccessToast");
  }

  String get knowledgeRoomTitle {
    return Intl.message("自习室", name: "knowledgeRoomTitle");
  }

  String get knowledgeLectureTitle {
    return Intl.message("讲堂", name: "knowledgeLectureTitle");
  }

  String get knowledgeXmlyTitle {
    return Intl.message("喜马拉雅", name: "knowledgeXmlyTitle");
  }

  String get xmlyRecentTitle {
    return Intl.message("最近", name: "xmlyRecentTitle");
  }

  String get xmlyCollectTitle {
    return Intl.message("收藏", name: "xmlyCollectTitle");
  }

  String get xmlyMoreTitle {
    return Intl.message("更多", name: "xmlyMoreTitle");
  }

  String get xmlySearchHint {
    return Intl.message("请输入专辑名称", name: "xmlySearchHint");
  }

  String get xmlyIsFinishedText {
    return Intl.message("完结", name: "xmlyIsFinishedText");
  }

  String get xmlyPlayCountUnit1 {
    return Intl.message("亿", name: "xmlyPlayCountUnit1");
  }

  String get xmlyPlayCountUnit2 {
    return Intl.message("万", name: "xmlyPlayCountUnit2");
  }

  String get xmlyPartNumUnit {
    return Intl.message("集", name: "xmlyPartNumUnit");
  }

  String get xmlySourceTitle {
    return Intl.message("内容来源：喜马拉雅APP", name: "xmlySourceTitle");
  }

  String get xmlyAlbumPlayTitle {
    return Intl.message("全部播放", name: "xmlyAlbumPlayTitle");
  }

  String get xmlyAlbumPauseTitle {
    return Intl.message("暂停播放", name: "xmlyAlbumPauseTitle");
  }

  String get xmlyAlbumContinueTitle {
    return Intl.message("继续播放", name: "xmlyAlbumContinueTitle");
  }

  String get xmlyAlbumPartNumUnit1 {
    return Intl.message("共", name: "xmlyAlbumPartNumUnit1");
  }

  String get xmlyPlayList {
    return Intl.message("播放列表", name: "xmlyPlayList");
  }

  String get xmlyPlayTimerClose {
    return Intl.message("定时关闭", name: "xmlyPlayTimerClose");
  }

  String get xmlyPlayTimerCloseDialogTimeUnit {
    return Intl.message("分钟", name: "xmlyPlayTimerCloseDialogTimeUnit");
  }

  String get xmlyPlayTimerCloseDialogCloseTitle {
    return Intl.message("关闭", name: "xmlyPlayTimerCloseDialogCloseTitle");
  }

  String get xmlyPlayModeList {
    return Intl.message("列表播放", name: "xmlyPlayModeList");
  }

  String get xmlyPlayModeSigleLoop {
    return Intl.message("单曲循环", name: "xmlyPlayModeSigleLoop");
  }

  String get xmlyPlayModeRandom {
    return Intl.message("随机播放", name: "xmlyPlayModeRandom");
  }

  String get xmlyPlayModeListLoop {
    return Intl.message("列表循环", name: "xmlyPlayModeListLoop");
  }

  String get xmlyPlaySortDesc {
    return Intl.message("倒序", name: "xmlyPlaySortDesc");
  }

  String get xmlyPlaySortAsc {
    return Intl.message("正序", name: "xmlyPlaySortAsc");
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
