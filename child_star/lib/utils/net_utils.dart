import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:child_star/utils/utils_index.dart';

class NetUtils {
  static Future<String> getIpAddress() async {
    if (AppUtils.isMobile) {
      for (var interface in await NetworkInterface.list()) {
        for (var address in interface.addresses) {
          var ip = address.address;
          if (ip != null && ip.isNotEmpty) {
            return ip;
          }
        }
      }
    }
    return "";
  }

  ///获取当前设备唯一ID
  static Future<String> getUniqueId() async {
    String uniqueId;
    try {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        uniqueId = androidDeviceInfo.androidId; // unique ID on Android
      } else if (Platform.isIOS) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        uniqueId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        uniqueId = null;
      }
    } catch (e) {
      uniqueId = null;
    }
    return uniqueId;
  }
}
