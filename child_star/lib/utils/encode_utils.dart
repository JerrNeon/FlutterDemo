// md5 加密
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fluro/fluro.dart';
import 'package:webview_flutter/webview_flutter.dart';

///MD5加密
String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

///中文编码
String chineseEncode(String originCn) {
  return jsonEncode(Utf8Encoder().convert(originCn));
}

///中文解码
String chineseDecode(String encodeCn) {
  var list = List<int>();
  return Utf8Decoder().convert(jsonDecode(encodeCn).forEach(list.add));
}

///处理[Router]中参数带有/报错的问题 (Route builders must never return null)
String encodeStringToBase64UrlSafeString(final String url) {
  var base64Codec = Base64Codec.urlSafe();
  return base64Codec.encode(utf8.encode(url));
}

///处理[Router]中参数带有/报错的问题 (Route builders must never return null)
String decodeFromBase64UrlSafeEncodedString(String str) {
  var base64Codec = Base64Codec.urlSafe();
  return utf8.decode(base64Codec.decode(str));
}

///处理[WebView]加载富文本的情况
String encodeStringToBase64RichText(String htmlText) {
  var contentBase64 = base64Encode(const Utf8Encoder().convert(htmlText));
  return "data:text/html;base64,$contentBase64";
}
