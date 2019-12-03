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
