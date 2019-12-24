import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/models/exercise.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildTop(data),
          ];
        },
        body: _buildWebView(data),
      ),
    );
  }

  Widget _buildTop(Exercise data) {
    return SliverPersistentHeader(
      delegate: CustomSliverPersistentHeaderDelegate(
        minHeight: MySizes.s_246,
        maxHeight: MySizes.s_246,
        child: Column(
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
                bottom: MySizes.s_12,
              ),
              child: Text(
                data.descr,
                style: TextStyle(
                  color: MyColors.c_777777,
                  fontSize: MyFontSizes.s_12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWebView(Exercise data) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: transformHtml(data.content),
      ),
      initialOptions: InAppWebViewWidgetOptions(),
    );
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
        onTap: () => RoutersNavigate().navigateToH5(
            context, data.jumpUrl),
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
