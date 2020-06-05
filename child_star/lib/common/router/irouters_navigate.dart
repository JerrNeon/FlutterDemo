import 'package:child_star/models/index.dart';
import 'package:child_star/routes/home/home_index.dart';
import 'package:child_star/routes/login/login_index.dart';
import 'package:child_star/routes/user/mine_index.dart';
import 'package:child_star/routes/exercise/exercise_index.dart';
import 'package:child_star/routes/knowledge/knowledge_index.dart';
import 'package:child_star/routes/consultation/consultation_index.dart';
import 'package:flutter/widgets.dart';

abstract class IRoutersNavigate {
  ///跳转到主页[MainPage]
  navigateToMain(
    BuildContext context, {
    bool replace = false,
    bool clearStack = false,
  });

  ///跳转到首页-搜索界面[HomeSearchPage]
  navigateToHomeSearch(BuildContext context);

  ///跳转到H5界面[H5Page]
  navigateToH5(BuildContext context, String url);

  ///跳转到资讯详情界面[NewDetailPage]
  navigateToNewDetail(BuildContext context, String newId);

  ///跳转到登录界面[LoginPage]
  navigateToLogin(BuildContext context);

  ///跳转到注册界面[RegisterPage]
  Future navigateToRegister(BuildContext context);

  ///跳转到忘记密码界面[ForgetPasswordPage]
  navigateToForgetPassword(BuildContext context);

  ///跳转到我的界面[MinePage]
  navigateToMine(BuildContext context);

  ///跳转到我的-设置界面[MineSetPage]
  navigateToMineSet(BuildContext context);

  ///跳转到我的-设置界面[ExerciseDetailPage]
  navigateToExerciseDetail(BuildContext context, String exerciseId);

  ///跳转到讲堂详情界面[LectureDetailPage]
  navigateToLectureDetail(BuildContext context, String lectureId);

  ///跳转到课程详情界面[CourseDetailPage]
  navigateToCourseDetail(BuildContext context, String courseId);

  ///跳转到作者主页界面[AuthorPage]
  navigateToAuthorPage(BuildContext context, String authorId);

  ///跳转到资讯搜索结果界面[HomeSearchResultPage]
  navigateToHomeSearchResultPage(BuildContext context, String id, String name);

  ///跳转到讲堂搜索界面[LectureSearchPage]
  navigateToLectureSearchPage(BuildContext context);

  ///跳转到讲堂搜索结果界面[LectureSearchResultPage]
  navigateToLectureSearchResultPage(BuildContext context, String name);

  ///跳转到讲堂搜索结果界面[HomeTagListPage]
  navigateToHomeTagListPage(BuildContext context);

  ///跳转到咨询问诊界面[InquiryPage]
  navigateToInquiryPage(BuildContext context);

  ///跳转到育儿百科标签列表界面[WikiTagPage]
  navigateToWikiTagPage(BuildContext context);

  ///跳转到育儿百科列表界面[WikiListPage]
  navigateToWikiListPage(
      BuildContext context, int index, String title, List<Tag> tagList);

  ///跳转到我的订单列表界面[MyOrderPage]
  navigateToMyOrderPage(BuildContext context);

  ///跳转到我的课程列表界面[MyCoursePage]
  navigateToMyCoursePage(BuildContext context);

  ///跳转到我的收藏列表界面[MyCollectionPage]
  navigateToMyCollectionPage(BuildContext context);

  ///跳转到我的关注列表界面[MyAttentionPage]
  navigateToMyAttentionPage(BuildContext context);

  ///跳转到修改用户信息界面[ModifyUserInfoPage]
  navigateToModifyUserInfoPage(BuildContext context);

  ///跳转到修改昵称和修改签名界面[ModifyNamePage]
  navigateToModifyNamePage(BuildContext context, int type);

  ///跳转到绘本书籍界面[MyBookPage]
  navigateToMyBookPage(BuildContext context);

  ///跳转到离线缓存界面[MyDownloadPage]
  navigateToMyDownloadPage(BuildContext context);

  ///跳转到缓存详情界面[DownloadDetailPage]
  navigateToDownloadDetailPage(BuildContext context, int type, String path);

  ///跳转到喜马拉雅搜索界面[XmlySearchPage]
  navigateToXmlySearchPage(BuildContext context);

  ///跳转到喜马拉雅分类界面[XmlyTypePage]
  navigateToXmlyTypePage(BuildContext context, int index);

  ///跳转到喜马拉雅专辑列表界面[XmlyAlbumPage]
  navigateToXmlyAlbumPage(BuildContext context, int id, String title);

  ///跳转到喜马拉雅专辑详情界面[XmlyAlbumDetailPage]
  navigateToXmlyAlbumDetailPage(BuildContext context, int id);

  ///跳转到喜马拉雅播放界面[XmlyPlayPage]
  navigateToXmlyPlayPage(BuildContext context);
}
