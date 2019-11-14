import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///网络请求
class Net {
  Net([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;

  static Dio dio = new Dio(BaseOptions(
    baseUrl: "https://api.github.com/",
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));

  static void init() {}
}
