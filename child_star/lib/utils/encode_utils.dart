// md5 加密
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

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
