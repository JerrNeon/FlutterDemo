import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class DownloadDetailPage extends StatelessWidget {
  final int type; //1：视频 2：音频 3：电子书
  final String path; //本地路径

  const DownloadDetailPage(this.type, this.path, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == 3 ? _buildPdfWidget(context) : _buildVideoWidget();
  }

  Widget _buildVideoWidget() {
    String url = decodeFromBase64UrlSafeEncodedString(path);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: VideoPlayerWidget(url),
      ),
    );
  }

  Widget _buildPdfWidget(BuildContext context) {
    String url = decodeFromBase64UrlSafeEncodedString(path);
    return PDFViewerScaffold(
      appBar: AppBarWidget2(GmLocalizations.of(context).mineBookDetail),
      path: url,
    );
  }
}
