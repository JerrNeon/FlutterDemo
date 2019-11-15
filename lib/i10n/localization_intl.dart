import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/i10n/messages_all.dart';
import 'package:intl/intl.dart';

class GmLocalizations {
  static Future<GmLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localName = Intl.canonicalizedLocale(name);
    return initializeMessages(localName).then((b) {
      Intl.defaultLocale = localName;
      return GmLocalizations();
    });
  }

  static GmLocalizations of(BuildContext context) {
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  String get title {
    return Intl.message(
      "Flutter App",
      name: "title",
      desc: "Title for the Demo application",
    );
  }

  String get home {
    return Intl.message(
      "Flutter Client",
      name: "home",
      desc: "Title for the home route",
    );
  }

  String get login {
    return Intl.message(
      "login",
      name: "login",
      desc: "Title for the login button",
    );
  }
}

//Local代理类
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  //是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalizations> load(Locale locale) {
    return GmLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(LocalizationsDelegate<GmLocalizations> old) {
    return false;
  }
}
