import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyBookPage extends StatefulWidget {
  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  DbUtils _dbUtils;
  Future<List<MediaCache>> _future;

  @override
  void initState() {
    super.initState();
    _future = _initDbUtils();
  }

  _initFuture() {
    _future = _dbUtils.getMediaCacheList([TYPE_EXERCISE]);
  }

  Future<List<MediaCache>> _initDbUtils() async {
    _dbUtils = DbUtils();
    await _dbUtils.open();
    return _dbUtils.getMediaCacheList([TYPE_EXERCISE]);
  }

  @override
  void dispose() {
    super.dispose();
    _dbUtils.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: MyColors.c_fafafa,
        child: Column(
          children: <Widget>[
            AppBarWidget(GmLocalizations.of(context).mineBook),
            Expanded(
              child: FutureBuilderWidget<List<MediaCache>>(
                future: _future,
                builder: (context, snapshot) {
                  List list = snapshot.data;
                  if (list != null && list.isNotEmpty) {
                    return ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: MySizes.s_14),
                      itemBuilder: (context, index) {
                        MediaCache data = list[index];
                        return DownloadItemWidget(
                          data: data,
                          onItemTap: () => _navigateToBookDetailPage(data),
                          onDeleteTap: () => _delete(data),
                        );
                      },
                    );
                  } else {
                    return NoDataWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToBookDetailPage(MediaCache data) {
    RoutersNavigate()
        .navigateToDownloadDetailPage(context, data.mediaType, data.path);
  }

  _delete(MediaCache data) {
    showCupertinoAlertDialog(
      context,
      content: GmLocalizations.of(context).downloadDeleteConfirmTitle,
      onPositiveTap: () {
        _dbUtils.delete(data.id);
        _initFuture();
        setState(() {});
      },
    );
  }
}
