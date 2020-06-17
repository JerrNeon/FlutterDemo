import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatefulWidget {
  final String id;

  ExerciseDetailPage(this.id);

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  Future<Exercise> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  _initFuture() {
    _future = NetManager(context).getExerciseDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
        child: FutureBuilderWidget<Exercise>(
          future: _future,
          onErrorRetryTap: () {
            _initFuture();
            setState(() {});
          },
          builder: (context, snapshot) {
            Exercise data = snapshot.data;
            return Column(
              children: <Widget>[
                AppBarWidget(
                  data.title,
                  isShowDivider: true,
                ),
                _buildBody(data),
                _buildBottom(data),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Exercise data) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          _buildTop(data),
          _buildWebView(data),
        ],
      ),
    );
  }

  Widget _buildTop(Exercise data) {
    //type 1：图文；2：电子书
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MySizes.s_4),
          child: loadImage(
            data.headUrl,
            width: double.infinity,
            height: MySizes.s_153,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MySizes.s_5,
            vertical: MySizes.s_12,
          ),
          child: Text(
            data.title,
            style: TextStyle(
              color: MyColors.c_777777,
              fontSize: MyFontSizes.s_15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MySizes.s_5,
            right: MySizes.s_5,
            bottom: data.type == 1 ? MySizes.s_12 : MySizes.s_6,
          ),
          child: Text(
            data.descr,
            style: TextStyle(
              color: MyColors.c_777777,
              fontSize: MyFontSizes.s_12,
            ),
          ),
        ),
        _buildDownload(data),
      ],
    );
  }

  Widget _buildDownload(Exercise data) {
    GmLocalizations gm = GmLocalizations.of(context);
    //1：图文；2：电子书
    if (data.type == 1) {
      return SizedBox();
    } else {
      return PaddingWidget(
        bottom: MySizes.s_12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_6,
                vertical: MySizes.s_2,
              ),
              decoration: BoxDecoration(
                color: MyColors.c_f2f2f2,
                borderRadius: BorderRadius.circular(MySizes.s_6),
              ),
              child: Text(
                gm.exerciseBookDownloadHint,
                style: TextStyle(
                  color: MyColors.c_a1a1a1,
                  fontSize: MyFontSizes.s_8,
                ),
              ),
            ),
            ExerciseDetailDownloadWidget(data: data),
          ],
        ),
      );
    }
  }

  Widget _buildWebView(Exercise data) {
    return WebViewWidget(data: data.content);
  }

  Widget _buildBottom(Exercise data) {
    bool isShow = data.btnName != null &&
        data.btnName.isNotEmpty &&
        data.jumpUrl != null &&
        data.jumpUrl.isNotEmpty;
    return Offstage(
      offstage: !isShow,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => RoutersNavigate().navigateToH5(context, data.jumpUrl),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MySizes.s_100,
            vertical: MySizes.s_12,
          ),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: MySizes.s_10),
            decoration: BoxDecoration(
              color: MyColors.c_ffa2b1,
              borderRadius: BorderRadius.circular(MySizes.s_20),
            ),
            child: Text(
              data.btnName,
              style: TextStyle(
                color: Colors.white,
                fontSize: MyFontSizes.s_12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
