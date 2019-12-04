import 'package:child_star/common/my_systems.dart';
import 'package:child_star/utils/encode_utils.dart';
import 'package:child_star/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class H5Page extends StatefulWidget {
  final String url;

  H5Page(this.url);

  @override
  _H5PageState createState() => _H5PageState();
}

class _H5PageState extends State<H5Page> {
  var title;
  WebViewController _controller;

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
                Expanded(
                  child: WebView(
                    initialUrl:
                        decodeFromBase64UrlSafeEncodedString(widget.url),
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController controller) {
                      _controller = controller;
                    },
                    onPageFinished: (url) {
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
    title = await _controller.getTitle();
    setState(() {});
  }
}
