import 'package:child_star/common/net/net.dart';
import 'package:child_star/models/index.dart';
import 'package:flutter/material.dart';

import 'net_config.dart';

class NetManager {
  NetManager([this.context]);

  final BuildContext context;

  Future<List<Tag>> getHotTagList() async {
    List response = await Net(context).post(NetConfig.GET_HOT_TAGS);
    return response.map((e) => Tag.fromJson(e)).toList();
  }

  /// id 1：资讯；2：讲堂；3：活动；默认：1
  Future<List<Banners>> getBannerList({int id = 1}) async {
    List response = await Net(context).post(NetConfig.GET_BANNERS, params: {
      "id": id,
    });
    return response.map((e) => Banners.fromJson(e)).toList();
  }

  /// pageNum	否	int	页数	默认1
  /// pageSize	否	int	页码大小	默认10
  /// sort	否	string	排序	最新:createTime； 最热：hot
  /// type	否	int	资讯类型	-1：全部；0：图文；1：视频；2：音频；3；百科； 默认：-1
  Future<Newslist> getNewsList(int pageIndex,
      {int pageSize = PAGE_SIZE, String sort = "createTime", int type = -1}) async {
    var response = await Net(context).post(NetConfig.GET_NEWS_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
      "sort": sort,
      "type": type,
    });
    return Newslist.fromJson(response);
  }
}
