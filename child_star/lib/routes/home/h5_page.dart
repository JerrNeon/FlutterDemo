import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/my_systems.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class H5Page extends StatefulWidget {
  final String url;

  H5Page(this.url);

  @override
  _H5PageState createState() =>
      _H5PageState(decodeFromBase64UrlSafeEncodedString(url));
}

class _H5PageState extends State<H5Page> {
  final String url;
  var title;
  double progress;
  InAppWebViewController _controller;

  _H5PageState(this.url);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: MySystems.noAppBarPreferredSize,
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                AppBarWidget(title ?? ""),
                Offstage(
                  offstage: progress == 1,
                  child: SizedBox(
                    height: MySizes.s_4,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(MyColors.c_ffa2b1),
                    ),
                  ),
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrl: url,
                    initialOptions: InAppWebViewWidgetOptions(
                      inAppWebViewOptions: InAppWebViewOptions(),
                    ),
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    //javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (InAppWebViewController controller) {
                      _controller = controller;
                    },
                    onLoadStop:
                        (InAppWebViewController controller, String url) {
                      _getTitle();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          if (_controller != null) {
            return await _controller.canGoBack().then((value) {
              _controller.goBack();
              return !value;
            });
          }
          return true;
        });
  }

  _getTitle() async {
    if (mounted) {
      title = await _controller.getTitle();
      setState(() {});
    }
  }
}
