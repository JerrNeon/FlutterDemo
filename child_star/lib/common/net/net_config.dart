const int PAGE_INDEX = 1;
const int PAGE_SIZE = 10;

class NetConfig {
  ///热门标签
  static const GET_HOT_TAGS = "tag/getHotTags";

  ///获取所有标签
  static const GET_TAG_LIST = "tag/getTags";

  ///顶部轮播图
  static const GET_BANNERS = "model/topBanner";

  ///获取最新资讯列表
  static const GET_NEWS_LIST = "info/getList";

  ///获取资讯详情
  static const GET_NEWS_DETAIL = "info/detail";

  ///搜索（相关）资讯列表
  static const GET_NEWS_SEARCH_LIST = "info/searchList";

  ///登录
  static const LOGIN = "auth/login";

  ///注册
  static const REGISTER = "auth/register";

  ///忘记密码
  static const FORGET_PASSWORD = "auth/forgetPassword";

  ///获取用户信息
  static const GET_USER_INFO = "user/info";

  ///退出登录
  static const LOGOUT = "auth/loginOut";

  ///获取验证码
  static const GET_VERIFY_CODE = "sapi/send_sms_code";

  ///获取讲堂列表
  static const GET_LECTURE_LIST = "course/getList";

  ///获取讲堂详情
  static const GET_LECTURE_DETAIL = "course/detail";

  ///获取课程列表
  static const GET_LECTURE_COURSE_LIST = "course/getSubjectList";

  ///获取讲堂评论列表
  static const GET_LECTURE_COMMENT_LIST = "course/getCourseCommentList";

  ///获取课程详情
  static const GET_COURSE_DETAIL = "course/getSubjectDetail";

  ///获取章节下课程列表
  static const GET_COURSE_PART_LIST = "course/getPartSubjectList";

  ///获取课程评论列表
  static const GET_COURSE_COMMENT_LIST = "course/getSubjectCommentList";

  ///查询讲堂列表
  static const GET_LECTURE_SEARCH_LIST = "course/searchList";

  ///活动主题标签列表
  static const GET_EXERCISE_TAG_LIST = "activity/getTags";

  ///活动列表
  static const GET_EXERCISE_LIST = "activity/getList";

  ///活动详情
  static const GET_EXERCISE_DETAIL = "activity/detail";

  ///关注作者资讯列表
  static const GET_ATTENTION_AUTHOR_NEWS_LIST = "info/followedList";

  ///推荐关注作者列表
  static const GET_RECOMMEND_AUTHOR_NEWS_LIST = "info/recommendAuthorList";

  ///作者详情页
  static const GET_AUTHOR_DETAIL = "author/detail";

  ///作者文章列表
  static const GET_AUTHOR_NEWS_LIST = "info/getAuthorInfoList";

  ///获取广告
  static const GET_ADVERTISEMENT = "model/getAdvert";
}
