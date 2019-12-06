// md5 加密
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

const String META = '''
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0,viewport-fit=cover,target-densitydpi=device-dpi\">
        ''';
const String CSS_STYLE =
    "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://mplanetasset.allyes.com/download/webview-reset.css\" >";
const String JS_HTML_HEIGHT = "document.body.scrollHeight";

///处理[WebView]加载富文本的情况
String encodeStringToBase64RichText(String htmlText) {
  var contentBase64 =
      base64Encode(const Utf8Encoder().convert("$META$CSS_STYLE$htmlText"));
  return "data:text/html;charset=utf-8;base64,$contentBase64";
}

///处理[InAppWebView]加载富文本的情况
String transformHtml(String htmlText) {
  return "$META$CSS_STYLE$htmlText";
}
