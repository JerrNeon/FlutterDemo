import 'dart:ui';

import 'package:child_star/i10n/i10n_index.dart';
import 'package:flutter/widgets.dart';

extension StringExtension on String {
  ///16进制数字符串转 int
  int hexNumToInt() {
    int val = 0;
    int len = this.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = this.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  ///如果后台返回的字符串中包含 '#', '0x' 前缀, 或者包含透明度，可处理一下
  int hexStrToInt() {
    var str = this.toUpperCase().replaceAll("#", "");
    str = str.replaceAll('0X', '');
    if (str.length == 6) {
      str = "FF" + str;
    }
    return int.parse(str, radix: 16);
  }
}

extension IntExtension on int {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  Color hexColor({double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((this & 0xFF0000) >> 16, (this & 0x00FF00) >> 8,
        (this & 0x0000FF) >> 0, alpha);
  }
}

class NumberUtils {
  static getPlayCount(BuildContext context, int playCount) {
    GmLocalizations gm = GmLocalizations.of(context);
    return playCount >= 100000000
        ? "${(playCount * 1.0 / 100000000).toStringAsFixed(2)}${gm.xmlyPlayCountUnit1}"
        : playCount >= 10000
            ? "${(playCount * 1.0 / 10000).toStringAsFixed(2)}${gm.xmlyPlayCountUnit2}"
            : playCount.toString();
  }
}
