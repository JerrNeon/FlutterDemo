import 'dart:io';

class AppUtils {
  ///当前是否是手机操作系统(Android or IOS)
  static bool get isMobile {
    bool isMobile;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        isMobile = true;
      } else {
        isMobile = false;
      }
    } catch (e) {
      isMobile = false;
    }
    return isMobile;
  }
}
