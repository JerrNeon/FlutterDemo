import 'package:child_star/common/resource_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
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
  var _title;
  double _progress;
  InAppWebViewController _controller;

  _H5PageState(this.url);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBarWidget(_title ?? ""),
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Offstage(
                  offstage: _progress == 1,
                  child: SizedBox(
                    height: MySizes.s_3,
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(MyColors.c_ffa2b1),
                    ),
                  ),
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      if (mounted) {
                        setState(() {
                          this._progress = progress / 100;
                        });
                      }
                    },
                    //javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (InAppWebViewController controller) {
                      _controller = controller;
                    },
                    onLoadStop:
                        (InAppWebViewController controller, Uri url) {
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
      _title = await _controller.getTitle();
      setState(() {});
    }
  }
}
