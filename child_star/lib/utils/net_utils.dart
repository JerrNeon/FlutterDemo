import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NetUtils {
  static Future<String> getIpAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var address in interface.addresses) {
        var ip = address.address;
        if (ip != null && ip.isNotEmpty) {
          return ip;
        }
      }
    }
    return "";
  }

  static Future<String> getUniqueId(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
