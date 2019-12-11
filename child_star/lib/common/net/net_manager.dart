import 'package:child_star/common/net/net.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
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
      {int pageSize = PAGE_SIZE,
      String sort = "createTime",
      int type = -1}) async {
    var response = await Net(context).post(NetConfig.GET_NEWS_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
      "sort": sort,
      "type": type,
    });
    return Newslist.fromJson(response);
  }

  ///id	是	int	资讯id
  Future<NewsDetail> getNewsDetail(String newsId) async {
    var response = await Net(context).post(NetConfig.GET_NEWS_DETAIL, params: {
      "id": newsId,
    });
    return NewsDetail.fromJson(response);
  }

  ///title和tagIds 至少传一个
  ///tagIds	否	string	标签id	title和tagIds 至少传一个, 多个标签用逗号隔开。例：1,2
  ///id	否	int	当前资讯id	用于相关资讯搜索
  ///pageNum	否	int	页数	默认1
  ///pageSize	否	int	页码大小	默认10
  ///sort	否	string	排序	最新:createTime； 最热：hot
  ///type	否	int	类型	-1：全部；0：图文；1：视频；2：音频；3：百科；默认 -1
  Future<Newslist> getNewsSearchList({
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
    String title,
    String tagIds,
    String id,
    String sort,
    int type,
  }) async {
    var params = {
      "pageNum": pageIndex,
      "pageSize": pageSize,
      "title": title,
      "tagIds": tagIds,
      "id": id,
      "sort": sort,
      "type": type,
    };
    var response =
        await Net(context).post(NetConfig.GET_NEWS_SEARCH_LIST, params: params);
    return Newslist.fromJson(response);
  }

  ///mobile	是	string	手机号
  ///password	是	string	密码
  ///deviceId	是	string	设备id
  ///ipAddress	是	string	ip地址
  Future<Token> login({
    @required String mobile,
    @required String password,
    String deviceId,
    String ipAddress,
  }) async {
    var uniqueId = await NetUtils.getUniqueId(context);
    var ip = await NetUtils.getIpAddress();
    LogUtils.d("uniqueId: $uniqueId ip: $ip");
    var response = await Net(context).post(NetConfig.LOGIN, params: {
      "mobile": mobile,
      "password": password,
      "deviceId": deviceId ?? uniqueId,
      "ipAddress": ipAddress ?? ip,
    });
    return Token.fromJson(response);
  }

  ///mobile	是	string	手机号
  ///password	是	string	密码
  ///code	是	int	验证码
  ///deviceId	是	string	设备id
  ///ipAddress	是	string	ip地址
  Future<Token> register({
    @required String mobile,
    @required String password,
    @required String code,
    @required String deviceId,
    String ipAddress,
  }) async {
    deviceId = await NetUtils.getUniqueId(context);
    ipAddress = await NetUtils.getIpAddress();
    var response = await Net(context).post(NetConfig.REGISTER, params: {
      "mobile": mobile,
      "password": password,
      "code": code,
      "deviceId": deviceId,
      "ipAddress": ipAddress,
    });
    return Token.fromJson(response);
  }

  ///mobile	是	string	手机号
  ///newPassword	是	string	新密码
  ///code	是	int	验证码
  Future forgetPassword({
    @required String mobile,
    @required String password,
    @required String code,
  }) async {
    return await Net(context).post(NetConfig.FORGET_PASSWORD, params: {
      "mobile": mobile,
      "newPassword": password,
      "code": code,
    });
  }

  Future<User> getUserInfo() async {
    var response = await Net(context).post(NetConfig.GET_USER_INFO);
    return User.fromJson(response);
  }
}
