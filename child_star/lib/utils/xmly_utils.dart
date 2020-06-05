import 'package:child_star/common/resource_index.dart';
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
  }) async {
    if (list != null && list.isNotEmpty) {
      XmlyData.albumId = albumId;
      XmlyData.isAsc = isAsc;
      XmlyData.totalPage = totalPage;
      XmlyData.totalSize = totalSize;
      XmlyData.pageSize = pageSize;
      XmlyData.prePage = prePage;
      XmlyData.page = page;
      bool isConnected = await Xmly().isConnected();
      if (isConnected) {
        Xmly().playList(list: list, playIndex: playIndex);
        RoutersNavigate().navigateToXmlyPlayPage(context);
      } else {
        _iConnectCallback = () {
          Xmly().removeOnConnectedListener(_iConnectCallback);
          _iConnectCallback = null;
          Xmly().playList(list: list, playIndex: playIndex);
          RoutersNavigate().navigateToXmlyPlayPage(context);
        };
        Xmly().addOnConnectedListener(_iConnectCallback);
        var packageInfo = await AppUtils.getPackageInfo();
        Xmly().initPlayer(
          notificationId: DateTime.now().millisecond,
          notificationClassName: "${packageInfo.packageName}.MainActivity",
        );
      }
    }
  }
}
