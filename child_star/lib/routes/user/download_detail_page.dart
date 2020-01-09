import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class DownloadDetailPage extends StatefulWidget {
  final int type; //1：视频 2：音频 3：电子书
  final String path; //本地路径

  const DownloadDetailPage(this.type, this.path, {Key key}) : super(key: key);

  @override
  _DownloadDetailPageState createState() =>
      _DownloadDetailPageState(type, path);
}

class _DownloadDetailPageState extends State<DownloadDetailPage> {
  final int type; //1：视频 2：音频 3：电子书
  final String path; //本地路径
  bool isShowBack = true;

  _DownloadDetailPageState(this.type, this.path);

  @override
  Widget build(BuildContext context) {
    return type == 3 ? _buildPdfWidget(context) : _buildVideoWidget(context);
  }

  Widget _buildVideoWidget(BuildContext context) {
    String url = decodeFromBase64UrlSafeEncodedString(path);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: VideoPlayerWidget(
              url,
              fullScreenEnable: true,
              onFullValueChanged: (value) {
                setState(() {
                  isShowBack = !value;
                });
              },
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Offstage(
              offstage: !isShowBack,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
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
