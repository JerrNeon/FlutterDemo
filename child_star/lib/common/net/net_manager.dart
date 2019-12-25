import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/material.dart';

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
    String deviceId,
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
      "pageIndex": pageIndex,
      "pageSize": pageSize,
    });
    return PageList<Lecture>.page(response, (e) => Lecture.fromJson(e));
  }

  Future<List<TagList>> getTagList() async {
    List response = await Net(context).post(NetConfig.GET_TAG_LIST);
    return response.map((e) => TagList.fromJson(e)).toList();
  }
}
