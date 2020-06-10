import 'dart:async';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_index.dart';

class XmlyPlayPage extends StatefulWidget {
  @override
  _XmlyPlayPageState createState() => _XmlyPlayPageState();
}

class _XmlyPlayPageState extends State<XmlyPlayPage> {
  IPlayStatusCallback _iPlayStatusCallback;
  Track _currTrack; //当前正在播放的声音
  bool _isPlaying = false; //是否正在播放
  double _progress = 0; //当前播放进度
  Timer _timer; //倒计时
  var _currentTime = 0; //当前倒计时剩余时长(单位：s)
  bool _isAsc = true; //是否升序

  @override
  void initState() {
    _initTrack();
    _initListener();
    super.initState();
  }

  @override
  void dispose() {
    if (_iPlayStatusCallback != null)
      Xmly().removePlayerStatusListener(_iPlayStatusCallback);
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      _timer = null;
    }
    super.dispose();
  }

  _initTrack() async {
    _currTrack = await Xmly().getCurrSound();
    _isPlaying = await Xmly().isPlaying();
    if (mounted) {
      setState(() {});
    }
  }

  _initListener() {
    _iPlayStatusCallback ??= IPlayStatusCallback();
    _iPlayStatusCallback.onPlayStart = () async {
      _isPlaying = true;
      if (mounted) {
        setState(() {});
      }
    };
    _iPlayStatusCallback.onPlayPause = () async {
      _isPlaying = false;
      if (mounted) {
        setState(() {});
      }
    };
    _iPlayStatusCallback.onSoundSwitch = () async {
      _currTrack = await Xmly().getCurrSound();
      if (mounted) {
        setState(() {});
      }
      print("xmly play -> onSoundSwitch");
    };
    _iPlayStatusCallback.onBufferProgress = (progress) async {};
    _iPlayStatusCallback.onPlayProgress = (progress) async {
      _progress = progress;
      if (mounted) {
        setState(() {});
      }
    };
    Xmly().addPlayerStatusListener(_iPlayStatusCallback);
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
        Text(
          _currTrack.trackTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: MyFontSizes.s_18,
            fontWeight: FontWeight.bold,
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
            Xmly().seekToByPercent(percent: value);
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
                  onPressed: () => Xmly().playPre(),
                ),
                SizedBox(width: MySizes.s_30),
                IconButton(
                  iconSize: MySizes.s_50,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (_isPlaying) {
                      await Xmly().pause();
                    } else {
                      await Xmly().play();
                    }

                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                SizedBox(width: MySizes.s_30),
                IconButton(
                  iconSize: MySizes.s_30,
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                  onPressed: () => Xmly().playNext(),
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
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return XmlyPlayListWidget(
            isAsc: _isAsc,
            valueChanged: (value) => _isAsc = value,
          );
        });
  }

  _onTapTimerClose() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return XmlyTimerCloseWidget(
            valueChanged: (index) async {
              int timeMillis;
              int currTimeMillis = DateTime.now().millisecond;
              if (index == 0) {
                //15分钟
                timeMillis = currTimeMillis + 15 * 60 * 1000;
              } else if (index == 1) {
                //30分钟
                timeMillis = currTimeMillis + 30 * 60 * 1000;
              } else if (index == 2) {
                //60分钟
                timeMillis = currTimeMillis + 60 * 60 * 1000;
              } else {
                //取消
                timeMillis = 0;
              }
              await Xmly().pausePlayInMillis(timeMillis);
              if (timeMillis != 0) {
                _currentTime = 15 * 60;
                _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  _currentTime--;
                  if (_currentTime == 0) {
                    timer.cancel();
                  }
                });
              } else {
                _currentTime = 0;
                if (_timer != null && _timer.isActive) {
                  _timer.cancel();
                }
              }
              if (mounted) {
                setState(() {});
              }
            },
          );
        });
  }
}
