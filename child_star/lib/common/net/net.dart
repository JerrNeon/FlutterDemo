import 'dart:convert';
import 'dart:io';

import 'package:child_star/common/global.dart';
import 'package:child_star/common/net/net_error.dart';
import 'package:child_star/utils/dialog_utils.dart';
import 'package:child_star/utils/encode_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Net {
  Net([this.context]);

  static const BASE_URL = "https://mplanet.allyes.com/api/";
  static const HEADER_AUTHORIZATION = "Authorization"; //Token
  static const HEADER_JSON = "application/json";
  static const CONNECT_TIME_OUT = 10000; //连接超时时间
  static const SEND_TIME_OUT = 10000; //请求超时时间
  static const RECEIVE_TIME_OUT = 3000; //响应超时时间
  static const GET = "get";
  static const POST = "post";

  static const APP_ID = "U2FsdGVkX1GwcRpbYrXPTfZfmwfPNpXFn9Wi6sT4g";
  static const APP_SECRET = "7p7yaBX+%.6V{7f^sfghvxsa";
  static const RESPONSE_CODE = "error";
  static const RESPONSE_MESSAGE = "message";
  static const RESPONSE_DATA = "data";

  static const CODE_200 = "200"; //Success
  static const CODE_201 = "201"; //Created
  static const CODE_400 = "400"; //Failure
  static const CODE_401 = "401"; //Unauthorized
  static const CODE_403 = "403"; //Forbidden
  static const CODE_404 = "404"; //Not Found
  static const CODE_10001 = "10001"; //参数错误
  static const CODE_10002 = "10002"; //未登陆(Token Invalid)
  static const CODE_10003 = "10003"; //没有权限
  static const CODE_10004 = "10004"; //系统繁忙
  static const CODE_10005 = "10005"; //请充值（知识点）
  static const CODE_10006 = "10006"; //需要VIP
  static const CODE_10007 = "10007"; //第三方登录需要绑定手机号
  static const CODE_11003 = "11003"; //第三方登录需要重新授权
  static const CODE_10013 = "10013"; //没有浏览权限（资讯）(Need Purchase Vip)

  BuildContext context;

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        HttpHeaders.acceptHeader: HEADER_JSON,
        HEADER_AUTHORIZATION: Global.profile.token
      },
      connectTimeout: CONNECT_TIME_OUT,
      sendTimeout: CONNECT_TIME_OUT,
      receiveTimeout: RECEIVE_TIME_OUT,
    ),
  );

  static void init() {
    //在调试模式下需要抓包，所以我们需要使用代理，并禁用https证书校验
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return 'PROXY 10.200.38.110:8888';
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  Future get(String url,
      {Map<String, dynamic> params,
      bool isShowErrorMsg = true,
      bool isShowDioErrorMsg = false}) async {
    return await _request(url,
        params: params,
        method: GET,
        isShowErrorMsg: isShowErrorMsg,
        isShowDioErrorMsg: isShowDioErrorMsg);
  }

  Future post(String url,
      {Map<String, dynamic> params,
      bool isShowErrorMsg = true,
      bool isShowDioErrorMsg = false}) async {
    return await _request(url,
        params: params,
        method: POST,
        isShowErrorMsg: isShowErrorMsg,
        isShowDioErrorMsg: isShowDioErrorMsg);
  }

  Future _request(String url,
      {String method,
      Map<String, dynamic> params,
      bool isShowErrorMsg = false,
      bool isShowDioErrorMsg = false}) async {
    LogUtils.i("<dio> url :<" + method + ">" + url);
    try {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          Global.profile.token;
      Response response;
      if (params != null && params.isNotEmpty) {
        params.removeWhere((key, value) {
          return value == null;
        });
        LogUtils.i("<dio> request :${params.toString()}");
      }
      if (method == GET) {
        response = await dio.get(url, queryParameters: params);
      } else {
        if (params != null && params.isNotEmpty) {
          String sign = "$APP_ID${jsonEncode(params)}$APP_SECRET";
          params.addAll({
            "sign": generateMd5(sign),
          });
        }
        response = await dio.post(url, data: params);
      }
      LogUtils.i("<dio> response :${response.data.toString()}");
      if (response.statusCode == HttpStatus.ok) {
        int code = response.data[RESPONSE_CODE];
        String message = response.data[RESPONSE_MESSAGE];
        var data = response.data[RESPONSE_DATA];
        if (code.toString() == CODE_200) {
          return data;
        } else {
          if (isShowErrorMsg && message != null && message.isNotEmpty) {
            showToast(message);
          }
          if (code.toString() == CODE_10002) {
            //请登录
          }
          return Future.error(
              NetError(response: response, code: code, message: message));
        }
      } else {
        return Future.error(
          DioError(
              request: response.request,
              response: response,
              type: DioErrorType.DEFAULT),
        );
      }
    } on DioError catch (e) {
      if (e != null &&
          isShowDioErrorMsg &&
          e.message != null &&
          e.message.isNotEmpty) {
        showToast(e.message);
      }
      return Future.error(e);
    }
  }
}
