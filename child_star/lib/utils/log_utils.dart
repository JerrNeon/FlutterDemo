import 'package:child_star/common/global.dart';

class LogUtils {
  ///灰色
  static v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Global.loggerNoStack.v(message, error, stackTrace);
  }

  ///白色
  static d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Global.loggerNoStack.d(message, error, stackTrace);
  }

  ///蓝色
  static i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Global.loggerNoStack.i(message, error, stackTrace);
  }

  ///黄色
  static w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Global.loggerNoStack.w(message, error, stackTrace);
  }

  ///红色
  static e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    Global.logger.e(message, error, stackTrace);
  }
}
