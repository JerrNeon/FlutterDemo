import 'dart:convert';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xmly/xmly_index.dart';

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
  Future<PageList<News>> getNewsList(int pageIndex,
      {int pageSize = PAGE_SIZE,
      String sort = "createTime",
      int type = -1}) async {
    var response = await Net(context).post(NetConfig.GET_NEWS_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
      "sort": sort,
      "type": type,
    });
    return PageList<News>.page(response, (e) => News.fromJson(e));
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
  Future<PageList<News>> getNewsSearchList({
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
    return PageList<News>.page(response, (e) => News.fromJson(e));
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
    var uniqueId = await NetUtils.getUniqueId();
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
    String deviceId,
    String ipAddress,
  }) async {
    deviceId = await NetUtils.getUniqueId();
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

  Future logout() async {
    return await Net(context).post(NetConfig.LOGOUT);
  }

  ///mobile	是	String	手机号	—
  ///time	是	int（或者string）	当前时间戳	—
  ///type	否	int	验证码类型	1：注册；2：绑定； 默认：1
  Future getVerifyCode({
    @required String mobile,
    String time,
    String type,
  }) async {
    if (time == null) {
      time = DateTime.now().millisecond.toString();
    }
    return await Net(context).post(NetConfig.GET_VERIFY_CODE, params: {
      "mobile": mobile,
      "time": time,
      "type": type,
    });
  }

  Future<PageList<Lecture>> getLectureList({
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response = await Net(context).post(NetConfig.GET_LECTURE_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<Lecture>.page(response, (e) => Lecture.fromJson(e));
  }

  Future<PageList<ExerciseTag>> getExerciseTagList({
    int pageIndex = PAGE_INDEX,
    int pageSize = PAGE_SIZE * 2,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_EXERCISE_TAG_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<ExerciseTag>.page(response, (e) => ExerciseTag.fromJson(e));
  }

  ///tagId	否	int	主题标签id	默认:0 (全部)
  ///pageNum	否	int	分页	默认：1
  ///pageSize	否	int	分页大小	默认：10
  Future<PageList<Exercise>> getExerciseList({
    @required int tagId,
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_EXERCISE_LIST, params: {
      "tagId": tagId,
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<Exercise>.page(response, (e) => Exercise.fromJson(e));
  }

  ///id	是	int	活动id
  Future<Exercise> getExerciseDetail({
    @required String id,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_EXERCISE_DETAIL, params: {
      "id": id,
    });
    return Exercise.fromJson(response);
  }

  ///id	是	int	讲堂id
  Future<LectureDetail> getLectureDetail({
    @required String id,
  }) async {
    var response = await Net(context).post(
      NetConfig.GET_LECTURE_DETAIL,
      params: {
        "id": id,
      },
    );
    return LectureDetail.fromJson(response);
  }

  ///id	是	int	讲堂id
  Future<PageList<Course>> getLectureCourseList({
    @required String id,
  }) async {
    var response = await Net(context).post(
      NetConfig.GET_LECTURE_COURSE_LIST,
      params: {
        "id": id,
      },
    );
    return PageList<Course>.page(response, (e) => Course.fromJson(e));
  }

  ///id	是	int	讲堂id
  ///pageNum	否	int	评论分页	默认：1
  ///pageSize	否	int	评论分页大小	默认：10
  ///replyPageNum	否	int	楼层回复分页	默认：1
  ///replyPageSize	否	int	楼层回复分页大小	默认：10
  Future<PageList<CourseComment>> getLectureCommentList({
    @required String id,
    @required int pageIndex,
    int pageSize,
    int replyPageIndex,
    int replyPageSize,
  }) async {
    var response = await Net(context).post(
      NetConfig.GET_LECTURE_COMMENT_LIST,
      params: {
        "id": id,
        "pageNum": pageIndex,
        "pageSize": pageSize,
        "replyPageNum": replyPageIndex,
        "replyPageSize": replyPageSize,
      },
    );
    return PageList<CourseComment>.page(
        response, (e) => CourseComment.fromJson(e));
  }

  ///id	是	int	课程id
  Future<CourseDetail> getCourseDetail(String id) async {
    var response = await Net(context).post(
      NetConfig.GET_COURSE_DETAIL,
      params: {
        "id": id,
      },
    );
    return CourseDetail.fromJson(response);
  }

  ///id	是	int	讲堂id
  ///partNo	是	int	章节序号
  Future<PageList<Course>> getCoursePartList({
    @required String id,
    @required int partNo,
  }) async {
    var response = await Net(context).post(
      NetConfig.GET_COURSE_PART_LIST,
      params: {
        "id": id,
        "partNo": partNo,
      },
    );
    return PageList<Course>.page(response, (e) => Course.fromJson(e));
  }

  ///id	是	int	课程id
  ///pageNum	否	int	评论分页	默认：1
  ///pageSize	否	int	评论分页大小	默认：10
  ///replyPageNum	否	int	楼层回复分页	默认：1
  ///replyPageSize	否	int	楼层回复分页大小	默认：10
  Future<PageList<CourseComment>> getCourseCommentList({
    @required String id,
    @required int pageIndex,
    int pageSize,
    int replyPageIndex,
    int replyPageSize,
  }) async {
    var response = await Net(context).post(
      NetConfig.GET_COURSE_COMMENT_LIST,
      params: {
        "id": id,
        "pageNum": pageIndex,
        "pageSize": pageSize,
        "replyPageNum": replyPageIndex,
        "replyPageSize": replyPageSize,
      },
    );
    return PageList<CourseComment>.page(
        response, (e) => CourseComment.fromJson(e));
  }

  ///pageNum	否	int	页数	默认1
  ///pageSize	否	int	页码大小	默认10
  Future<PageList<Author>> getAttentionAuthorNewsList({
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response = await Net(context)
        .post(NetConfig.GET_ATTENTION_AUTHOR_NEWS_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<Author>.page(response, (e) => Author.fromJson(e));
  }

  ///pageNum	否	int	页数	默认1
  ///pageSize	否	int	页码大小	默认10
  Future<PageList<Author>> getRecommendAuthorNewsList({
    int pageIndex = PAGE_INDEX,
    int pageSize = PAGE_SIZE,
  }) async {
    var response = await Net(context)
        .post(NetConfig.GET_RECOMMEND_AUTHOR_NEWS_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<Author>.page(response, (e) => Author.fromJson(e));
  }

  ///id	是	int	作者id
  Future<Author> getAuthorDetail(String id) async {
    var response =
        await Net(context).post(NetConfig.GET_AUTHOR_DETAIL, params: {
      "id": id,
    });
    return Author.fromJson(response);
  }

  ///authorId	是	int	作者id
  Future<PageList<News>> getAuthorNewsList(String authorId) async {
    var response =
        await Net(context).post(NetConfig.GET_AUTHOR_NEWS_LIST, params: {
      "authorId": authorId,
    });
    return PageList<News>.page(response, (e) => News.fromJson(e));
  }

  ///title	是	int	关键字
  ///pageNum	否	int	页数	默认1
  ///pageSize	否	int	页码大小	默认10
  Future<PageList<Lecture>> getLectureSearchList({
    @required String title,
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_LECTURE_SEARCH_LIST, params: {
      "title": title,
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<Lecture>.page(response, (e) => Lecture.fromJson(e));
  }

  Future<List<TagList>> getTagList() async {
    List response = await Net(context).post(NetConfig.GET_TAG_LIST);
    return response.map((e) => TagList.fromJson(e)).toList();
  }

  ///id	否	int	广告模块id	1：打开APP广告；默认：1
  Future<List<Banners>> getAdvertisement({int id = 1}) async {
    List response =
        await Net(context).post(NetConfig.GET_ADVERTISEMENT, params: {
      "id": id,
    });
    return response.map((e) => Banners.fromJson(e)).toList();
  }

  Future<Chunyu> getChunYuUrl() async {
    var response = await Net(context).post(NetConfig.GET_CHUNYUURL);
    return Chunyu.fromJson(response);
  }

  Future<List<WikiTagList>> getWikiTagList() async {
    List response = await Net(context).post(NetConfig.GET_WIKI_TAG_LIST);
    return response.map((e) => WikiTagList.fromJson(e)).toList();
  }

  /// wikiTagId	是	int	百科标签id
  /// pageNum	否	int	页数	默认1
  /// pageSize	否	int	页码大小	默认10
  Future<PageList<News>> getWikiList({
    @required String tagId,
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response = await Net(context).post(NetConfig.GET_WIKI_LIST, params: {
      "wikiTagId": tagId,
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList.page(response, (e) => News.fromJson(e));
  }

  ///pageNum	否	int	页数	默认：1
  ///pageSize	否	int	分页大小	默认：10
  Future<PageList<MyOrder>> getMyOrderList({
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_MY_ORDER_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList.page(response, (e) {
      //amount、price、total字段类型不一致
      dynamic amount = e["amount"];
      dynamic price = e["price"];
      dynamic total = e["total"];
      if (amount is num) {
        e["amount"] = amount.toString();
      }
      if (price is num) {
        e["price"] = price.toString();
      }
      if (total is num) {
        e["total"] = total.toString();
      }
      return MyOrder.fromJson(e);
    });
  }

  ///type	否	int	1：收费课程；2：免费课程； 默认：1
  ///pageNum	否	int	页数	默认：1
  ///pageSize	否	int	分页大小	默认：10
  Future<PageList<MyCourse>> getMyCourseList({
    int type = 1,
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_MY_COURSE_LIST, params: {
      "type": type,
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList.page(response, (e) => MyCourse.fromJson(e));
  }

  ///type	否	int	收藏类型：1：资讯；2：讲堂 默认1
  ///pageNum	否	int	页数	默认：1
  ///pageSize	否	int	分页大小	默认：10
  Future<PageList<MyCollection>> getMyCollectionList({
    int type = 1,
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_MY_COLLECTION_LIST, params: {
      "type": type,
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList.page(response, (e) => MyCollection.fromJson(e));
  }

  ///pageNum	否	int	页数	默认：1
  ///pageSize	否	int	分页大小	默认：10
  Future<PageList<MyAttention>> getMyAttentionList({
    @required int pageIndex,
    int pageSize = PAGE_SIZE,
  }) async {
    var response =
        await Net(context).post(NetConfig.GET_MY_ATTENTION_LIST, params: {
      "pageNum": pageIndex,
      "pageSize": pageSize,
    });
    return PageList.page(response, (e) => MyAttention.fromJson(e));
  }

  ///id	是	int	收藏的id
  ///type	是	string	收藏类型：1：资讯；2：讲堂(非课程)；
  Future<Result> doCollection({
    @required String id,
    @required int type,
  }) async {
    var response = await Net(context).post(NetConfig.DO_COLLECT, params: {
      "id": id,
      "type": type,
    });
    return Result.fromJson(response);
  }

  ///id	是	int	点赞对象 id
  ///type	是	int	点赞类型：1：资讯；2：讲堂(非课程)；3：资讯评论（id传评论id）
  Future<Result> doLike({
    @required String id,
    @required int type,
  }) async {
    var response = await Net(context).post(NetConfig.DO_FAVORITE, params: {
      "id": id,
      "type": type,
    });
    return Result.fromJson(response);
  }

  ///authorId	是	int	作者id
  Future<Result> doFollow({
    @required String authorId,
  }) async {
    var response = await Net(context).post(NetConfig.DO_FOLLOW, params: {
      "authorId": authorId,
    });
    User user = await getUserInfo();
    Provider.of<UserProvider>(context).saveUser(user);
    return Result.fromJson(response);
  }

  /// headUrl	否	string	头像
  /// nickName	否	string	昵称
  /// tagId	否	string	标签id
  /// country	否	string	国家
  /// province	否	string	省份
  /// city	否	string	城市
  /// sex	否	string	性别1：男；2：女
  /// mySign	否	string	个性签名
  /// birthday	否	string	生日
  Future modifyUserInfo({
    String headUrl,
    String nickName,
    String tagId,
    String country,
    String province,
    String city,
    String sex,
    String mySign,
    String birthday,
  }) async {
    return await Net(context).post(NetConfig.MODIFY_USERINFO, params: {
      "headUrl": headUrl,
      "nickName": nickName,
      "tagId": tagId,
      "country": country,
      "province": province,
      "city": city,
      "sex": sex,
      "mySign": mySign,
      "birthday": birthday,
    });
  }

  ///file	是	multipart/form-data	文件流	支持格式jpg,png,jpeg,gif,mp3,mp4
  Future<String> uploadFile({
    String filePath,
  }) async {
    var data = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath),
    });
    return await Net(context).post(NetConfig.UPLOAD_FILE, data: data);
  }
}

class XmlyNetManager {
  factory XmlyNetManager() => _getInstacne();

  static XmlyNetManager _instance;

  XmlyNetManager._();

  static XmlyNetManager _getInstacne() {
    if (_instance == null) {
      _instance = XmlyNetManager._();
    }
    return _instance;
  }

  ///get请求
  Future<String> baseGetRequest({
    @required String url,
    Map<String, String> params,
  }) {
    if (params != null && params.isNotEmpty) {
      params.removeWhere((key, value) {
        return value == null;
      });
    }
    return Xmly().baseGetRequest(url: url, params: params);
  }

  ///获取焦点图
  Future<XmlyBannersPageList> getBannerList({
    int bannerContentType =
        2, //	Int	否	焦点图类型 0-不限 1-单个用户 2-单个专辑，3-单个声音，4-链接，9-听单，默认值为0
    int scope = 2, //	Long	否	查询范围 0-全部，1-喜马焦点图，2-开发者自运营焦点图，默认为0
    int isPaid = 0, //	Int	否	是否付费： 1：付费 ，0：免费 ，-1：不限
    String sortBy, //	String	否	排序字段 可选值：created_at、update_at 默认值：updated_at
    String sort, //	String	否	desc-降序排列 asc-升序排列 默认值：desc
    int page = 1, //	Int	否	返回第几页，从1开始，默认为1
    int count = 20, //	Int	否	每页大小，范围为[1,200]，默认为20
  }) async {
    String jsonStr =
        await baseGetRequest(url: XmlyNetConfig.GET_BANNERS, params: {
      "banner_content_type": bannerContentType.toString(),
      "scope": scope.toString(),
      "is_paid": isPaid.toString(),
      "sort_by": sortBy,
      "sort": sort,
      "page": page.toString(),
      "count": count.toString(),
    });
    return XmlyBannersPageList.fromJson(json.decode(jsonStr));
  }

  ///多筛选条件搜索听单
  Future<ColumnsPageList> getColumnList({
    String id, //	Long	否	听单ID
    String title, //	String	否	听单标题
    int contentType = 1, //	Int	否	内容类型： 1：专辑 2：声音
    String
        scopes, //String	否	数据范围 可选值：xm、developer。 xm：喜马系统听单 developer：开发者自建听单 多个范围用逗号隔开，例如：xm,developer 默认值：developer
    String sort, //	String	否	desc-降序排列 asc-升序排列 默认值：desc
    int page = 1, //	Int	否	返回第几页，从1开始，默认为1
    int count = 20, //	Int	否	每页大小，范围为[1,200]，默认为20
  }) async {
    String jsonStr =
        await baseGetRequest(url: XmlyNetConfig.GET_COLUMNS, params: {
      "id": id,
      "title": title,
      "content_type": contentType.toString(),
      "scopes": scopes,
      "sort": sort,
      "page": page.toString(),
      "count": count.toString(),
    });
    return ColumnsPageList.fromJson(json.decode(jsonStr));
  }

  ///批量获取听单信息
  Future<ColumnsPageList> getColumnBatchList({
    String ids, //	String	是	以英文逗号隔开的听单ID，一次最多传200个，超出部分的ID会被忽略
  }) async {
    String jsonStr =
        await baseGetRequest(url: XmlyNetConfig.GET_COLUMNS_BATCH, params: {
      "ids": ids,
    });
    return ColumnsPageList.fromJson(json.decode(jsonStr));
  }

  ///分页获取听单内容
  Future<ColumnsAlbumPageList> getAlbumList({
    @required int id, //听单ID
    int page = 1,
    int count = 20,
  }) async {
    String jsonStr =
        await baseGetRequest(url: XmlyNetConfig.GET_COLUMN_CONTENT, params: {
      "id": id.toString(),
      "page": page.toString(),
      "count": count.toString(),
    });
    return ColumnsAlbumPageList.fromJson(json.decode(jsonStr));
  }

  ///批量获取听单信息并且根据听单信息获取部分听单内容
  Future<ColumnBatchAlbumPageList> getColumnBatchAlbumList({
    String ids, //	String	是	以英文逗号隔开的听单ID，一次最多传200个，超出部分的ID会被忽略
    int page = 1,
    int count = 20,
  }) async {
    ColumnsPageList columnsPageList = await getColumnBatchList(ids: ids);
    ColumnBatchAlbumPageList columnBatchAlbumPageList =
        ColumnBatchAlbumPageList(columns: columnsPageList.columns);
    List<Columns> columns = columnsPageList.columns;
    if (columns != null && columns.isNotEmpty) {
      List<Future<ColumnsAlbumPageList>> list = columns.map((e) async {
        return await getAlbumList(id: e.id, page: page, count: count);
      }).toList();
      columnBatchAlbumPageList.albumFutures = list;
      return columnBatchAlbumPageList;
    }
    return null;
  }

  ///获取开发者收藏专辑(搜索专辑)
  Future<AlbumPageList> getCollectedAlbumList({
    String id, //Long	否	专辑ID
    String albumTitle, //String	否	专辑名称
    int isPaid = 0, //Int	否	默认值：不限 是否付费： 1：付费 0：免费 -1：不限
    String sortBy, //String	否	排序字段 可选值：play_count、updated_at 默认值：updated_at
    String sort, //String	否	desc-降序排列 asc-升序排列 默认值：desc
    int page = 1,
    int count = 20,
  }) async {
    String jsonStr = await baseGetRequest(
        url: XmlyNetConfig.GET_DEVELOPER_COLLECTED_ALBUMS,
        params: {
          "id": id,
          "album_title": albumTitle,
          "is_paid": isPaid.toString(),
          "sort_by": sortBy,
          "sort": sort,
          "page": page.toString(),
          "count": count.toString(),
        });
    return AlbumPageList.fromJson(json.decode(jsonStr));
  }

  ///多筛选条件搜索专辑
  Future<AlbumPageList> getSearchAlbumList({
    @required int id, //专辑ID
    int page = 1,
    int count = 1,
  }) async {
    String jsonStr =
        await baseGetRequest(url: XmlyNetConfig.GET_SEARCHED_ALBUMS, params: {
      "id": id.toString(),
      "page": page.toString(),
      "count": count.toString(),
    });
    return AlbumPageList.fromJson(json.decode(jsonStr));
  }

  ///专辑浏览
  Future<TrackPageList> getTracks({
    @required int albumId, //专辑ID
    String sort = "asc",
    int page = 1,
    int count = 20,
  }) async {
    String jsonStr =
        await baseGetRequest(url: XmlyNetConfig.GET_TRACKS, params: {
      "album_id": albumId.toString(),
      "sort": sort,
      "page": page.toString(),
      "count": count.toString(),
    });
    return TrackPageList.fromJson(json.decode(jsonStr));
  }
}
