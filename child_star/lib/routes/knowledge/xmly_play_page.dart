import 'dart:async';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_plugin.dart';

class XmlyPlayPage extends StatefulWidget {
  @override
  _XmlyPlayPageState createState() => _XmlyPlayPageState();
}

class _XmlyPlayPageState extends State<XmlyPlayPage> {
  final xmly = Xmly();
  StreamSubscription _onPlayStartSubscription;
  StreamSubscription _onPlayPauseSubscription;
  StreamSubscription _onSoundPreparedSubscription;
  StreamSubscription _onPlayProgressSubscription;
  Track _currTrack; //当前正在播放的声音
  bool _isPlaying = false; //是否正在播放
  bool _isLoading = true; //是否正在加载
  double _progress = 0; //当前播放进度
  Timer _timer; //倒计时
  var _currentTime = 0; //当前倒计时剩余时长(单位：s)

  @override
  void initState() {
    _initCountDownTimer();
    _initTrack();
    _initListener();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null && _timer.isActive) {
      _cancelTimer();
      XmlyData.countDownTime = _currentTime;
      _timer = null;
    }
    _onPlayStartSubscription?.cancel();
    _onPlayPauseSubscription?.cancel();
    _onSoundPreparedSubscription?.cancel();
    _onPlayProgressSubscription?.cancel();
    super.dispose();
  }

  ///初始化倒计时，恢复上次未完成的倒计时(定时关闭)
  _initCountDownTimer() {
    _currentTime = XmlyData.countDownTime ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  ///开始倒计时
  _startTimer() {
    if (_currentTime != 0) {
      _cancelTimer();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _currentTime--;
        if (_currentTime == 0) {
          timer.cancel();
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  ///取消倒计时
  _cancelTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  ///获取播放状态，当前正在播放的声音信息
  _initTrack() async {
    _currTrack = await xmly.getCurrSound();
    _isPlaying = await xmly.isPlaying();
    if (mounted) {
      setState(() {});
    }
  }

  ///初始化播放状态回调
  _initListener() {
    _onPlayStartSubscription = xmly.onPlayStart.listen((event) async {
      LogUtils.d("xmly play -> onPlayStart");
      _isLoading = false;
      _isPlaying = true;
      if (mounted) {
        setState(() {});
      }
    });
    _onPlayPauseSubscription = xmly.onPlayPause.listen((event) async {
      LogUtils.d("xmly play -> onPlayPause");
      _isLoading = false;
      _isPlaying = false;
      if (mounted) {
        setState(() {});
      }
    });
    _onSoundPreparedSubscription = xmly.onSoundPrepared.listen((event) async {
      LogUtils.d("xmly play -> onSoundPrepared");
      _isLoading = true;
      _isPlaying = false;
      _currTrack = await xmly.getCurrSound();
      if (mounted) {
        setState(() {});
      }
    });
    _onPlayProgressSubscription = xmly.onPlayProgress.listen((progress) async {
      _isLoading = false;
      _progress = progress;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      backgroundColor: MyColors.c_6a8994,
      body: _currTrack != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildTop(gm),
                _buildBottom(gm),
              ],
            )
          : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
    );
  }

  Widget _buildTop(GmLocalizations gm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: MySizes.s_16,
                vertical: MySizes.s_12,
              ),
              child: Image(image: MyImages.ic_login_back),
            ),
          ),
        ),
        SizedBox(height: MySizes.s_30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MySizes.s_20),
          child: Text(
            _currTrack.trackTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: MyFontSizes.s_18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: MySizes.s_50),
        Stack(
          children: <Widget>[
            loadImage(
              _currTrack.coverUrlMiddle,
              width: MySizes.s_212,
              height: MySizes.s_212,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: XmlyPlayCountWidget(playCount: _currTrack.playCount ?? 0),
            ),
          ],
        ),
        SizedBox(height: MySizes.s_50),
        Text(
          gm.xmlySourceTitle,
          style: TextStyle(
            color: MyColors.c_e2e2e2,
            fontSize: MyFontSizes.s_11,
          ),
        ),
      ],
    );
  }

  Widget _buildBottom(GmLocalizations gm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Slider(
          value: _progress,
          onChanged: (value) {
            _progress = value;
          },
          onChangeEnd: (value) {
            xmly.seekToByPercent(percent: value);
          },
          inactiveColor: Colors.white30,
          activeColor: Colors.white,
          label:
              "${TimeUtils.formatDateS(_currTrack.duration * _progress)}/${TimeUtils.formatDateS(_currTrack.duration)}",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _onTapPlayList(),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(image: MyImages.ic_xmly_play_list),
                    SizedBox(height: MySizes.s_2),
                    Text(
                      gm.xmlyPlayList,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MyFontSizes.s_9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  iconSize: MySizes.s_30,
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                  onPressed: () => xmly.playPre(),
                ),
                SizedBox(width: MySizes.s_30),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: MySizes.s_70,
                      height: MySizes.s_70,
                      child: Offstage(
                        offstage: !_isLoading,
                        child: CircularProgressIndicator(
                          strokeWidth: MySizes.s_2,
                          valueColor: AlwaysStoppedAnimation(Colors.white70),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: MySizes.s_50,
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (_isPlaying) {
                          await xmly.pause();
                        } else {
                          await xmly.play();
                        }
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: MySizes.s_30),
                IconButton(
                  iconSize: MySizes.s_30,
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                  onPressed: () => xmly.playNext(),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _onTapTimerClose(),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image(image: MyImages.ic_xmly_play_timerclose),
                    SizedBox(height: MySizes.s_2),
                    Text(
                      _currentTime != 0
                          ? TimeUtils.formatDateS(_currentTime)
                          : gm.xmlyPlayTimerClose,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MyFontSizes.s_9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }

  _onTapPlayList() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return XmlyPlayListWidget();
        });
  }

  _onTapTimerClose() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return XmlyTimerCloseWidget(
            valueChanged: (index) async {
              int timeMillis;
              int currTimeMillis = DateTime.now().millisecondsSinceEpoch;
              if (index == 0) {
                //15分钟
                timeMillis = currTimeMillis + 15 * 60 * 1000;
                _currentTime = 15 * 60;
              } else if (index == 1) {
                //30分钟
                timeMillis = currTimeMillis + 30 * 60 * 1000;
                _currentTime = 30 * 60;
              } else if (index == 2) {
                //60分钟
                timeMillis = currTimeMillis + 60 * 60 * 1000;
                _currentTime = 60 * 60;
              } else {
                //取消
                timeMillis = 0;
                _currentTime = 0;
              }
              await xmly.pausePlayInMillis(timeMillis);
              if (timeMillis != 0) {
                _startTimer();
              } else {
                _cancelTimer();
              }
            },
          );
        });
  }
}
