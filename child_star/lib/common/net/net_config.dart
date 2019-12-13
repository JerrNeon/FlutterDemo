const int PAGE_INDEX = 1;
const int PAGE_SIZE = 10;

class NetConfig {
  ///热门标签
  static const GET_HOT_TAGS = "tag/getHotTags";

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
}
