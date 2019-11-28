import 'dart:convert';
import 'dart:io';

import 'package:child_star/common/global.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/encode_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'net_config.dart';

const APP_ID = "U2FsdGVkX1GwcRpbYrXPTfZfmwfPNpXFn9Wi6sT4g";
const APP_SECRET = "7p7yaBX+%.6V{7f^sfghvxsa";

const RESPONSE_CODE = "error";
const RESPONSE_MESSAGE = "message";
const RESPONSE_DATA = "data";

class Net {
  Net([this.context]);

  static const BASE_URL = "	https://mplanet.allyes.com/api/";
  static const HEADER_AUTHORIZATION = "Authorization"; //Token
  static const TIME_OUT = 10000; //连接、请求、响应超时时间

  BuildContext context;

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      headers: {HEADER_AUTHORIZATION: Global.profile.token},
      connectTimeout: TIME_OUT,
      sendTimeout: TIME_OUT,
      receiveTimeout: TIME_OUT,
    ),
  );

  static void init() {
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(SignInterceptor());
  }

  Future<List<Tag>> getHotTagList(BuildContext context) async {
    var response = await Net.dio.post<List>(NetConfig.GET_HOT_TAGS);
    return response.data.map((e) => Tag.fromJson(e)).toList();
  }
}

class SignInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    //sign = MD5（appid+jsonObject.toString+appsecret）
    String sign = "$APP_ID${options.data.toString()}$APP_SECRET";
    options.data = jsonDecode(generateMd5(sign));
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    if (response.statusCode == HttpStatus.ok) {
      if (response.data[RESPONSE_CODE] == HttpStatus.ok) {
      } else {}
    }
    return super.onResponse(response);
  }
}
