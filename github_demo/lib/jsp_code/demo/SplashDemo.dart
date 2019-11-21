import 'package:flutter/material.dart';

import 'Home.dart';

class SplashDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SplashDemo",
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: SplashWidget(),
    );
  }
}

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int _duration;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _duration = _controller.duration.inMilliseconds ~/ 1000;

    _animation.addListener(() {
      setState(() {
        Duration lastElapsedDuration = _controller.lastElapsedDuration;
        if (lastElapsedDuration != null) {
          _duration = (_controller.duration.inMilliseconds -
                  lastElapsedDuration.inMilliseconds) ~/
              1000;
        }
      });
    });
    /*动画事件监听器，
    它可以监听到动画的执行状态，
    我们这里只监听动画是否结束，
    如果结束则执行页面跳转动作。 */
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (route) => route == null);
      }
    });
    //播放动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        //透明度动画组件
        opacity: _animation, //执行动画
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546851657199&di=fdd278c2029f7826790191d59279dbbe&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0112cb554438090000019ae93094f1.jpg%401280w_1l_2o_100sh.jpg',
              scale: 2.0, //进行缩放
              fit: BoxFit.cover, //充满父容器
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  '剩余$_duration' 's',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
              ),
            )
          ],
        ));
  }
}
