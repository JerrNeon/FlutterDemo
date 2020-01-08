import 'dart:io';

import 'package:child_star/utils/log_utils.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static get separator => Platform.pathSeparator;
  static const DOWNLOAD_DIRECTORY_NAME = "download";

  static Future<String> getDownloadPath(String fileName) async {
    var tempDir;
    if (Platform.isAndroid) {
      tempDir = await getExternalStorageDirectory();
    } else {
      tempDir = await getApplicationSupportDirectory();
    }
    var directory =
        Directory("${tempDir.path}$separator$DOWNLOAD_DIRECTORY_NAME");
    try {
      bool exists = await directory.exists();
      if (!exists) {
        directory.createSync();
      }
      return "${directory.path}$separator$fileName";
    } catch (e) {
      LogUtils.e(e);
      return fileName;
    }
  }
}
