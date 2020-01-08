import 'package:child_star/common/resource_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DownloadDetailPage extends StatelessWidget {
  final int type; //1：视频 2：音频 3：电子书
  final String path; //本地路径

  const DownloadDetailPage(this.type, this.path, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "$type : ${decodeFromBase64UrlSafeEncodedString(path)}",
          style: TextStyle(
            fontSize: MyFontSizes.s_16,
          ),
        ),
      ),
    );
  }
}
