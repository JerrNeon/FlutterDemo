import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/widgets.dart';
import 'package:xmly/xmly_index.dart';

class XmlyUtils {
  static IConnectCallback _iConnectCallback;

  static playList(
    BuildContext context, {
    @required List<Track> list,
    @required int playIndex,
    int albumId,
    bool isAsc = true,
    int totalPage,
    int totalSize,
    int pageSize = XmlyData.PAGE_SIZE,
    int prePage,
    int page,
    bool isNavigateToXmlyPlayPage = true,
  }) async {
    if (list != null && list.isNotEmpty) {
      bool isUpdatePlayList;
      if (albumId != XmlyData.albumId) {
        isUpdatePlayList = true;
      } else if (isAsc != XmlyData.isAsc) {
        isUpdatePlayList = true;
      } else {
        List<Track> playList = await Xmly().getPlayList();
        if (list.length != playList.length) {
          isUpdatePlayList = true;
        } else {
          isUpdatePlayList = false;
        }
      }
      XmlyData.albumId = albumId;
      XmlyData.isAsc = isAsc;
      XmlyData.totalPage = totalPage;
      XmlyData.totalSize = totalSize;
      XmlyData.pageSize = pageSize;
      XmlyData.prePage = prePage;
      XmlyData.page = page;
      bool isConnected = await Xmly().isConnected();
      if (isConnected) {
        if (isUpdatePlayList) {
          XmlyData.isPlayAsc = true;
          Xmly().playList(list: list, playIndex: playIndex);
        } else {
          int currentIndex = await Xmly().getCurrentIndex();
          if (currentIndex != playIndex) {
            Xmly().play(playIndex: playIndex);
          } else {
            bool isPlaying = await Xmly().isPlaying();
            if (!isPlaying) {
              Xmly().play();
            }
          }
        }
        if (isNavigateToXmlyPlayPage) {
          RoutersNavigate().navigateToXmlyPlayPage(context);
        }
      } else {
        _iConnectCallback = () async {
          XmlyData.isPlayAsc = true;
          await Xmly().playList(list: list, playIndex: playIndex);
          await Xmly()
              .removeOnConnectedListener(_iConnectCallback, isCancel: true);
          _iConnectCallback = null;
          if (isNavigateToXmlyPlayPage) {
            RoutersNavigate().navigateToXmlyPlayPage(context);
          }
        };
        await Xmly().addOnConnectedListener(_iConnectCallback);
        var packageInfo = await AppUtils.getPackageInfo();
        LogUtils.d("xmly utils -> ${packageInfo.packageName}.MainActivity");
        await Xmly().initPlayer(
          notificationId: DateTime.now().millisecond,
          notificationClassName: "${packageInfo.packageName}.MainActivity",
        );
      }
    }
  }

  ///自动加载前一页数据到播放列表
  static autoLoadPreToPlayList({
    ValueChanged<List<Track>> onDataChanged,
    VoidCallback onErrorCallback,
  }) async {
    try {
      int pageIndex;
      if (XmlyData.isPlayAsc) {
        XmlyData.prePage--;
        pageIndex = XmlyData.prePage;
      } else {
        XmlyData.page++;
        pageIndex = XmlyData.page;
      }
      TrackPageList trackPageList = await XmlyNetManager().getTracks(
        albumId: XmlyData.albumId,
        sort: XmlyData.isAsc ? XmlyData.ASC : XmlyData.DESC,
        page: pageIndex,
      );
      if (trackPageList != null &&
          trackPageList.tracks != null &&
          trackPageList.tracks.isNotEmpty) {
        List<Track> list = trackPageList.tracks;
        await Xmly().insertTracksToPlayListHead(list: list);
        if (onDataChanged != null) {
          onDataChanged.call(list);
        }
      }
    } catch (e) {
      if (XmlyData.isPlayAsc) {
        XmlyData.prePage++;
      } else {
        XmlyData.page--;
      }
      if (onErrorCallback != null) {
        onErrorCallback.call();
      }
    }
  }

  ///自动加载后一页数据到播放列表
  static autoLoadNextToPlayList({
    ValueChanged<List<Track>> onDataChanged,
    VoidCallback onErrorCallback,
  }) async {
    try {
      int pageIndex;
      if (XmlyData.isPlayAsc) {
        XmlyData.page++;
        pageIndex = XmlyData.page;
      } else {
        XmlyData.prePage--;
        pageIndex = XmlyData.prePage;
      }
      TrackPageList trackPageList = await XmlyNetManager().getTracks(
        albumId: XmlyData.albumId,
        sort: XmlyData.isAsc ? XmlyData.ASC : XmlyData.DESC,
        page: pageIndex,
      );
      if (trackPageList != null &&
          trackPageList.tracks != null &&
          trackPageList.tracks.isNotEmpty) {
        List<Track> list = trackPageList.tracks;
        await Xmly().addTracksToPlayList(list: list);
        if (onDataChanged != null) {
          onDataChanged.call(list);
        }
      }
    } catch (e) {
      if (XmlyData.isPlayAsc) {
        XmlyData.page--;
      } else {
        XmlyData.prePage++;
      }
      if (onErrorCallback != null) {
        onErrorCallback.call();
      }
    }
  }
}
