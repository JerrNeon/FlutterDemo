import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:logger/logger.dart';

///应用入口信息初始化
class Global {
  static Profile profile; //Token、用户信息

  static var logger = Logger(); //日志打印
  static var loggerNoStack = Logger(
    //日志打印(不打印所在日志关联的方法信息)
    printer: PrettyPrinter(methodCount: 0),
  );

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    //Release不打印日志
    if (isRelease) {
      Logger.level = Level.nothing;
    }

    profile = await SpUtils.init();
    Net.init();
    Routers.init();
  }

  static void saveProfile() {
    SpUtils.saveProfile(profile);
  }
}
