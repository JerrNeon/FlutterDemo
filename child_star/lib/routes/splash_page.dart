import 'dart:async';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<List<Banners>> _future;
  var time = 4;
  Timer _timer;
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    //设置状态栏透明
    SystemChrome.setSystemUIOverlayStyle(MySystems.transparent);
    _future = NetManager(context).getAdvertisement();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        time--;
        if (time > 0) {
          setState(() {});
        } else {
          timer.cancel();
          _navigatetoMainPage();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: MyImages.bg_splash,
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder<List<Banners>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data.isEmpty) {
              _cancelTimer();
              _navigatetoMainPage();
              return EmptyWidget();
            } else {
              return Container(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    AdvertisementWidget(
                      key: _globalKey,
                      banners: snapshot.data[0],
                      width: double.infinity,
                      onTap: () {
                        _cancelTimer();
                        _navigatetoMainPage();
                        _handlerAdClick();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        _cancelTimer();
                        _navigatetoMainPage();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MySizes.s_28,
                          right: MySizes.s_18,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: MySizes.s_12,
                          vertical: MySizes.s_5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(MySizes.s_20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              GmLocalizations.of(context).splashSkipTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MyFontSizes.s_16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: MySizes.s_6),
                              child: VerticalDividerWidget(
                                color: Colors.white,
                                height: MySizes.s_15,
                              ),
                            ),
                            Text(
                              "$time",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MyFontSizes.s_16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            return EmptyWidget();
          }
        },
      ),
    );
  }

  _cancelTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  _navigatetoMainPage() {
    RoutersNavigate().navigateToMain(context, replace: true);
  }

  _handlerAdClick() {
    (_globalKey.currentWidget as AdvertisementWidget)
        .handlerBannerClick(context);
  }
}
