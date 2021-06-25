import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/db_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

enum DownloadStatus {
  NO_DOWNLOAD, //未下载
  DOWNLOADING, //下载中
  DOWNLOAD_COMPLETE, //下载完成
}

class ExerciseDetailDownloadWidget extends StatefulWidget {
  final Exercise data;

  const ExerciseDetailDownloadWidget({Key key, @required this.data})
      : super(key: key);

  @override
  _ExerciseDetailDownloadWidgetState createState() =>
      _ExerciseDetailDownloadWidgetState(data);
}

class _ExerciseDetailDownloadWidgetState
    extends State<ExerciseDetailDownloadWidget> {
  final Exercise data;
  Future _future;
  DbUtils _dbUtils;
  MediaCache _mediaCache;
  DownloadStatus _downloadStatus;
  String downloadProgress;

  _ExerciseDetailDownloadWidgetState(this.data);

  @override
  void initState() {
    super.initState();
    _future = _initDbUtils();
  }

  Future _initDbUtils() async {
    _dbUtils = DbUtils();
    await _dbUtils.open();
    _mediaCache = await _dbUtils.getMediaCache(data.id);
    _downloadStatus = _mediaCache != null
        ? DownloadStatus.DOWNLOAD_COMPLETE
        : DownloadStatus.NO_DOWNLOAD;
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return EmptyFutureBuilderWidget(
      future: _future,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () {
            if (_downloadStatus == DownloadStatus.NO_DOWNLOAD) {
              _download();
            } else if (_downloadStatus == DownloadStatus.DOWNLOAD_COMPLETE) {
              _navigateToDownloadDetailPage();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: MySizes.s_96,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: MySizes.s_8),
            decoration: BoxDecoration(
              color: MyColors.c_ffa2b1,
              borderRadius: BorderRadius.circular(MySizes.s_15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _downloadStatus == DownloadStatus.NO_DOWNLOAD
                  ? <Widget>[
                      Image(image: MyImages.ic_exercise_download),
                      SizedBox(width: MySizes.s_4),
                      Text(
                        gm.exerciseBookDownload,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MyFontSizes.s_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  : _downloadStatus == DownloadStatus.DOWNLOAD_COMPLETE
                      ? <Widget>[
                          Image(image: MyImages.ic_exercise_read),
                          SizedBox(width: MySizes.s_4),
                          Text(
                            gm.exerciseBookRead,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MyFontSizes.s_12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      : <Widget>[
                          Text(
                            gm.exerciseBookDownloading,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MyFontSizes.s_12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: MySizes.s_5),
                          Text(
                            "$downloadProgress",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MyFontSizes.s_14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MyFontSizes.s_10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
            ),
          ),
        );
      },
    );
  }

  _download() async {
    String downloadUrl = data.downloadUrl;
    var result = await Permission.storage.request();
    if (result.isGranted) {
      var fileName = downloadUrl
          .substring(downloadUrl.lastIndexOf(FileUtils.separator) + 1);
      var savePath = await FileUtils.getDownloadPath(fileName);
      _downloadStatus = DownloadStatus.DOWNLOADING;
      await Net(context).download(downloadUrl, savePath,
          onReceiveProgress: (count, total) {
        downloadProgress = (count / total * 100).toStringAsFixed(0);
        setState(() {});
      });
      await _dbUtils.open();
      _mediaCache = MediaCache()
        ..type = TYPE_EXERCISE
        ..mediaId = data.id
        ..mediaType = 3
        ..imageUrl = data.headUrl
        ..title = data.title
        ..desc = data.descr
        ..url = downloadUrl
        ..path = savePath;
      var result = await _dbUtils.insert(_mediaCache);
      LogUtils.i("insert result: $result");
      _downloadStatus = DownloadStatus.DOWNLOAD_COMPLETE;
      setState(() {});
    }
  }

  _navigateToDownloadDetailPage() {
    RoutersNavigate().navigateToDownloadDetailPage(
        context, _mediaCache.mediaType, _mediaCache.path);
  }
}
