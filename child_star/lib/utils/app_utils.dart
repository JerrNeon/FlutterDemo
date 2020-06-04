import 'dart:io';

import 'package:package_info/package_info.dart';

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

  ///获取App名称、包名、版本信息
  static Future<PackageInfo> getPackageInfo() {
    return PackageInfo.fromPlatform();
  }
}
