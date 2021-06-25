import 'package:flutter/cupertino.dart';

class GmCupertinoLocalizations {
  static const _GmCupertinoLocalizationsDelegate delegate =
      _GmCupertinoLocalizationsDelegate();
}

class _GmCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _GmCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) {
    return false;
  }
}
