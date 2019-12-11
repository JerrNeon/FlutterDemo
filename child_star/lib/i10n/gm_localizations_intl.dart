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

  String get loginSubmitTitle {
    return Intl.message("确认", name: "loginSubmitTitle");
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
