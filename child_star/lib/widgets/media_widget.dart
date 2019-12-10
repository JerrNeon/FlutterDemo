import 'dart:async';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url; //视频Url
  final bool isAutoPlay; //是否自动播放

  VideoPlayerWidget(this.url, {this.isAutoPlay = true});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;
  var isPlay = true;
  double progress = 0;
  var isShowUI = false;
  Timer _uiTimer;
  Timer _progressTimer;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          if (widget.isAutoPlay) {
            _controller.play();
          }
        });
        setProgress();
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _uiTimer?.cancel();
    _progressTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.initialized
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: GestureDetector(
                      onTap: () {
                        if (isPlay) {
                          setState(() {
                            isShowUI = !isShowUI;
                          });
                          hideUI();
                        }
                      },
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  Offstage(
                    offstage: !isShowUI,
                    child: GestureDetector(
                      onTap: () {
                        if (isPlay) {
                          _controller.pause();
                          isPlay = false;
                        } else {
                          _controller.play();
                          isPlay = true;
                          hideUI();
                        }
                        setState(() {});
                      },
                      child: Image(image: MyImagesMultiple.video_play[isPlay]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: MySizes.s_2,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(MyColors.c_ffa2b1),
                ),
              ),
            ],
          )
        : Container();
  }

  void setProgress() {
    _progressTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      int currentDuration = _controller.value.position.inSeconds;
      int totalDuration = _controller.value.duration.inSeconds;
      progress = currentDuration / totalDuration;
      LogUtils.d("progress: $progress = $currentDuration / $totalDuration");
      if (progress == 1) {
        timer.cancel();
        isShowUI = true;
        isPlay = false;
      }
      setState(() {});
    });
  }

  void hideUI() {
    _uiTimer?.cancel();
    _uiTimer = Timer(Duration(seconds: 4), () {
      setState(() {
        isShowUI = false;
      });
    });
  }
}
