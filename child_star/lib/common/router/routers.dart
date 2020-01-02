import 'package:child_star/routes/consultation/consultation_index.dart';
import 'package:child_star/routes/exercise/exercise_index.dart';
import 'package:child_star/routes/home/home_index.dart';
import 'package:child_star/routes/knowledge/knowledge_index.dart';
import 'package:child_star/routes/login/login_index.dart';
import 'package:child_star/routes/main_page.dart';
import 'package:child_star/routes/user/mine_index.dart';
import 'package:child_star/states/profile_notifier.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Routers {
  static const String root = "/";
  static const String h5 = "/h5";
  static const String home_search = "/home/search";
  static const String home_new_detail = "/home/new_detail";
  static const String author_homepage = "/home/attention/author";
  static const String home_search_result = "/home/search/result";
  static const String home_tag_list = "/home/tag_list";
  static const String login = "/user/login";
  static const String register = "/user/register";
  static const String forget_password = "/user/forget_password";
  static const String mine = "/user/mine";
  static const String mine_set = "/user/mine/set";
  static const String exercise_detail = "/exercise/detail";
  static const String lecture_detail = "/lecture/detail";
  static const String course_detail = "/lecture/detail/course_detail";
  static const String lecture_search = "/lecture/search";
  static const String lecture_search_result = "/lecture/search/result";
  static const String consultation_inquiry = "/consultation/inquiry";
  static const String consultation_wiki_tag = "/consultation/wiki_tag";
  static const String consultation_wiki_list = "/consultation/wiki_tag/list";
  static const String mine_my_order = "/user/mine/my_order";
  static const String mine_my_course = "/user/mine/my_course";
  static const String mine_my_collection = "/user/mine/my_collection";
  static const String mine_my_attention = "/user/mine/my_attention";
  static const String mine_modify_userinfo = "/user/mine/modify_userinfo";
  static const String mine_modify_name =
      "/user/mine/modify_userinfo/modify_name";

  static var router = Router();

  static init() {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      LogUtils.e("route was not found");
      return null;
    });
    router.define(root, handler: _mainHandler);
    router.define(home_search, handler: _homeSearchHandler);
    router.define(h5, handler: _h5Handler);
    router.define(home_new_detail, handler: _homeNewDetailHandler);
    router.define(login, handler: _loginHandler);
    router.define(register, handler: _registerHandler);
    router.define(forget_password, handler: _forgetPasswordHandler);
    router.define(mine, handler: _mineHandler);
    router.define(mine_set, handler: _mineSetHandler);
    router.define(exercise_detail, handler: _exerciseDetailHandler);
    router.define(lecture_detail, handler: _lectureDetailHandler);
    router.define(course_detail, handler: _courseDetailHandler);
    router.define(author_homepage, handler: _authorHomePageHandler);
    router.define(home_search_result, handler: _homeSearchResultPageHandler);
    router.define(lecture_search, handler: _lectureSearchPageHandler);
    router.define(lecture_search_result,
        handler: _lectureSearchResultPageHandler);
    router.define(home_tag_list, handler: _homeTagListPageHandler);
    router.define(consultation_inquiry, handler: _consultationInquiryHandler);
    router.define(consultation_wiki_tag, handler: _consultationWikiTagHandler);
    router.define(consultation_wiki_list,
        handler: _consultationWikiListHandler);
    router.define(mine_my_order, handler: _myOrderHandler);
    router.define(mine_my_course, handler: _myCourseHandler);
    router.define(mine_my_collection, handler: _myCollectionHandler);
    router.define(mine_my_attention, handler: _myAttentionHandler);
    router.define(mine_modify_userinfo, handler: _modifyUserInfoHandler);
    router.define(mine_modify_name, handler: _modifyNameHandler);
  }
}

bool _isLogin(BuildContext context) {
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return userProvider.isLogin;
}

var _mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MainPage();
});

var _homeSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomeSearchPage();
});

var _h5Handler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String url = parameters["url"]?.first ?? "";
  return H5Page(url);
});

var _homeNewDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return NewDetailPage(id);
});

var _loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginPage();
});

var _registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RegisterPage();
});

var _forgetPasswordHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return ForgetPasswordPage();
});

var _mineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? MinePage() : LoginPage();
});

var _mineSetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MineSetPage();
});

var _exerciseDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return ExerciseDetailPage(id);
});

var _lectureDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return _isLogin(context) ? LectureDetailPage(id) : LoginPage();
});

var _courseDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return _isLogin(context) ? CourseDetailPage(id) : LoginPage();
});

var _authorHomePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return _isLogin(context) ? AuthorPage(id) : LoginPage();
});

var _homeSearchResultPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  String name = parameters["name"]?.first ?? "";
  return HomeSearchResultPage(
    id: id,
    name: name,
  );
});

var _lectureSearchPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LectureSearchPage();
});

var _lectureSearchResultPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String name = parameters["name"]?.first ?? "";
  return LectureSearchResultPage(name);
});

var _homeTagListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomeTagListPage();
});

var _consultationInquiryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return InquiryPage();
});

var _consultationWikiTagHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return WikiTagPage();
});

var _consultationWikiListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  int index = int.tryParse(parameters["index"]?.first ?? "") ?? 0;
  String title = parameters["title"]?.first ?? "";
  String tagList = parameters["tagList"]?.first ?? "";
  return WikiListPage(
    index: index,
    title: title,
    tagList: tagList,
  );
});

var _myOrderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? MyOrderPage() : LoginPage();
});

var _myCourseHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? MyCoursePage() : LoginPage();
});

var _myCollectionHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? MyCollectionPage() : LoginPage();
});

var _myAttentionHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? MyAttentionPage() : LoginPage();
});

var _modifyUserInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? ModifyUserInfoPage() : LoginPage();
});

var _modifyNameHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  int type = int.tryParse(parameters["type"]?.first ?? "") ?? 0;
  return _isLogin(context) ? ModifyNamePage(type) : LoginPage();
});
