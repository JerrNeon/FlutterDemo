import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/utils/log_utils.dart';
import 'package:child_star/utils/statusbar_utils.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum PlayerState { stopped, playing, paused }

class VideoPlayerWidget extends StatefulWidget {
  final String url; //视频Url
  final bool isAutoPlay; //是否自动播放
  final fullScreenEnable; //是否可以全屏
  final ValueChanged onFullValueChanged; //全屏监听

  VideoPlayerWidget(
    this.url, {
    this.isAutoPlay = true,
    this.fullScreenEnable = false,
    this.onFullValueChanged,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;
  PlayerState _playerState = PlayerState.stopped;
  double progress = 0;
  var isShowUI = false;
  bool _isFullScreen = false;
  Timer _uiTimer;
  Timer _progressTimer;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          if (widget.isAutoPlay) {
            _play();
          }
        });
        _setProgress();
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
    //屏幕尺寸
    Size size = MediaQuery.of(context).size;
    //全屏时的比例
    double screenAspectRatio = size.width / size.height;
    return _controller.value.initialized
        ? WillPopScope(
            onWillPop: () async {
              if (_isFullScreen) {
                _fullScreen();
                return false;
              }
              return true;
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: _isFullScreen
                      ? screenAspectRatio
                      : _controller.value.aspectRatio,
                  child: GestureDetector(
                    onTap: () {
                      if (_playerState == PlayerState.playing) {
                        setState(() {
                          isShowUI = !isShowUI;
                        });
                        _hideUI();
                      }
                    },
                    child: VideoPlayer(_controller),
                  ),
                ),
                //播放图标
                Offstage(
                  offstage: !isShowUI,
                  child: GestureDetector(
                    onTap: () {
                      if (_playerState == PlayerState.playing) {
                        _pause();
                        setState(() {});
                        _progressTimer?.cancel();
                        _uiTimer?.cancel();
                      } else {
                        _play();
                        setState(() {});
                        if (!_progressTimer.isActive) {
                          _setProgress();
                        }
                        _hideUI();
                      }
                    },
                    child: Image(
                        image: MyImagesMultiple
                            .video_play[_playerState == PlayerState.playing]),
                  ),
                ),
                //全屏图标
                widget.fullScreenEnable
                    ? Positioned(
                        right: 0,
                        bottom: 0,
                        child: Offstage(
                          offstage: !isShowUI,
                          child: GestureDetector(
                            onTap: () {
                              _fullScreen();
                              _hideUI();
                            },
                            behavior: HitTestBehavior.opaque,
                            child: PaddingWidget(
                              right: MySizes.s_8,
                              bottom: MySizes.s_12,
                              child: Image(
                                  image: MyImages.ic_videoplay_fullscreen),
                            ),
                          ),
                        ),
                      )
                    : EmptyWidget(),
                //返回图标
                widget.fullScreenEnable && _isFullScreen
                    ? Positioned(
                        left: 0,
                        top: 0,
                        child: Offstage(
                          offstage: !isShowUI,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _fullScreen();
                              _hideUI();
                            },
                          ),
                        ),
                      )
                    : EmptyWidget(),
                //进度条
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: MySizes.s_2,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(MyColors.c_ffa2b1),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  _play() {
    _controller.play();
    _playerState = PlayerState.playing;
  }

  _pause() {
    _controller.pause();
    _playerState = PlayerState.paused;
  }

  _setProgress() {
    _progressTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      int currentDuration = _controller.value.position.inSeconds;
      int totalDuration = _controller.value.duration.inSeconds;
      progress = currentDuration / totalDuration;
      LogUtils.d("progress: $progress = $currentDuration / $totalDuration");
      if (progress == 1) {
        timer.cancel();
        isShowUI = true;
        _playerState = PlayerState.stopped;
      }
      setState(() {});
    });
  }

  _hideUI() {
    _uiTimer?.cancel();
    _uiTimer = Timer(Duration(seconds: 4), () {
      setState(() {
        isShowUI = false;
      });
    });
  }

  _fullScreen() {
    if (_isFullScreen) {
      StatusBarUtils.portrait();
      StatusBarUtils.setDark();
      _isFullScreen = false;
    } else {
      StatusBarUtils.landscape();
      _isFullScreen = true;
    }
    if (widget.onFullValueChanged != null) {
      widget.onFullValueChanged(_isFullScreen);
    }
  }
}

class AudioPlayerWidget extends StatefulWidget {
  final String url; //音频Url
  final bool isAutoPlay; //是否自动播放
  final bool isLocal; //是否本地文件
  final PlayerMode mode;

  AudioPlayerWidget(
    this.url, {
    this.isAutoPlay = true,
    this.isLocal,
    this.mode = PlayerMode.MEDIA_PLAYER,
  });

  @override
  _AudioPlayerWidgetState createState() =>
      _AudioPlayerWidgetState(url, isAutoPlay, isLocal, mode);
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  String url;
  final bool isAutoPlay;
  bool isLocal;
  PlayerMode mode;

  AudioPlayer _audioPlayer;
  // ignore: unused_field
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get isPlaying => _playerState == PlayerState.playing;

  get isPaused => _playerState == PlayerState.paused;

  get durationText => _duration?.toString()?.split('.')?.first ?? '';

  get positionText => _position?.toString()?.split('.')?.first ?? '';

  _AudioPlayerWidgetState(this.url, this.isAutoPlay, this.isLocal, this.mode);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    if (isAutoPlay) {
      _play();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MySizes.s_6),
      decoration: BoxDecoration(
        color: MyColors.c_ffa2b1,
        borderRadius: BorderRadius.circular(MySizes.s_26),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Image(image: MyImages.ic_newdetail_audiowave),
          ),
          Positioned(
            top: MySizes.s_2,
            left: MySizes.s_2,
            bottom: MySizes.s_2,
            child: GestureDetector(
              onTap: () {
                if (_playerState == PlayerState.playing) {
                  _pause();
                } else {
                  _play();
                }
              },
              child: Image(
                  image: MyImagesMultiple
                      .audio_play[_playerState == PlayerState.playing]),
            ),
          ),
        ],
      ),
    );
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);

      if (Theme.of(context).platform == TargetPlatform.iOS) {
        // (Optional) listen for notification updates in the background
        _audioPlayer.startHeadlessService();

        // set at least title to see the notification bar on ios.
        _audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30),
            // default is 30s
            backwardSkipInterval: const Duration(seconds: 30),
            // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0));
      }
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });

    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _audioPlayerState = state);
    });
  }

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result =
        await _audioPlayer.play(url, isLocal: isLocal, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // default playback rate is 1.0
      // this should be called after _audioPlayer.play() or _audioPlayer.resume()
      // this can also be called everytime the user wants to change playback rate in the UI
      _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    }

    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  // ignore: unused_element
  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }
}
