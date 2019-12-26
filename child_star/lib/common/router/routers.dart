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

  static var router = Router();

  static init() {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      LogUtils.e("route was not found");
      return null;
    });
    router.define(root, handler: mainHandler);
    router.define(home_search, handler: homeSearchHandler);
    router.define(h5, handler: h5Handler);
    router.define(home_new_detail, handler: homeNewDetailHandler);
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
    router.define(forget_password, handler: forgetPasswordHandler);
    router.define(mine, handler: mineHandler);
    router.define(mine_set, handler: mineSetHandler);
    router.define(exercise_detail, handler: exerciseDetailHandler);
    router.define(lecture_detail, handler: lectureDetailHandler);
    router.define(course_detail, handler: courseDetailHandler);
    router.define(author_homepage, handler: authorHomePageHandler);
    router.define(home_search_result, handler: homeSearchResultPageHandler);
    router.define(lecture_search, handler: lectureSearchPageHandler);
    router.define(lecture_search_result,
        handler: lectureSearchResultPageHandler);
    router.define(home_tag_list, handler: homeTagListPageHandler);
    router.define(consultation_inquiry, handler: consultationInquiryHandler);
    router.define(consultation_wiki_tag, handler: consultationWikiTagHandler);
    router.define(consultation_wiki_list, handler: consultationWikiListHandler);
  }
}

bool _isLogin(BuildContext context) {
  UserProvider userProvider = Provider.of<UserProvider>(context);
  return userProvider.isLogin;
}

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MainPage();
});

var homeSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomeSearchPage();
});

var h5Handler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String url = parameters["url"]?.first ?? "";
  return H5Page(url);
});

var homeNewDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return NewDetailPage(id);
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginPage();
});

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RegisterPage();
});

var forgetPasswordHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return ForgetPasswordPage();
});

var mineHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return _isLogin(context) ? MinePage() : LoginPage();
});

var mineSetHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return MineSetPage();
});

var exerciseDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return ExerciseDetailPage(id);
});

var lectureDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return _isLogin(context) ? LectureDetailPage(id) : LoginPage();
});

var courseDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return _isLogin(context) ? CourseDetailPage(id) : LoginPage();
});

var authorHomePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  return _isLogin(context) ? AuthorPage(id) : LoginPage();
});

var homeSearchResultPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String id = parameters["id"]?.first ?? "";
  String name = parameters["name"]?.first ?? "";
  return HomeSearchResultPage(
    id: id,
    name: name,
  );
});

var lectureSearchPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LectureSearchPage();
});

var lectureSearchResultPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  String name = parameters["name"]?.first ?? "";
  return LectureSearchResultPage(name);
});

var homeTagListPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return HomeTagListPage();
});

var consultationInquiryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return InquiryPage();
});

var consultationWikiTagHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return WikiTagPage();
});

var consultationWikiListHandler = Handler(
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
