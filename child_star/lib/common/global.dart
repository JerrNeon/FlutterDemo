import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:xmly/xmly_index.dart';

///应用入口信息初始化
class Global {
  static Profile profile; //Token、用户信息

  static var logger = Logger(); //日志打印
  static var loggerNoStack = Logger(
    //日志打印(不打印所在日志关联的方法信息)
    printer: PrettyPrinter(methodCount: 0),
  );

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    //Release不打印日志
    if (isRelease) {
      Logger.level = Level.nothing;
    }

    profile = await SpUtils.init();
    Net.init();
    Routers.init();
  }

  static Future initXmly() async {
    await Xmly.isDebug(isDebug: !isRelease);
    PackageInfo packageInfo = await AppUtils.getPackageInfo();
    await Xmly.init(
      appKey: "857b7fc3d1ab3a0388f1c27a63f3ef85",
      packId: packageInfo.packageName,
      appSecret: "21b73a1e994be13be6673b8d9d3a0151",
    );
    await Xmly.useHttps(useHttps: true);
    await Xmly.isTargetSDKVersion24More(isTargetSDKVersion24More: true);
  }

  static void saveProfile() {
    SpUtils.saveProfile(profile);
  }
}
