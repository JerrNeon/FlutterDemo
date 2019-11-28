import 'package:dio/dio.dart';

class NetError {
  NetError({
    this.response,
    this.code,
    this.message,
  });

  /// Response info, it may be `null` if the request can't reach to
  /// the http server, for example, occurring a dns error, network is not available.
  Response response;

  int code;

  String message;
}
