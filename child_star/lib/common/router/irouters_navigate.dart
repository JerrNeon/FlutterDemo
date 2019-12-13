import 'package:child_star/routes/home/home_index.dart';
import 'package:child_star/routes/login/login_index.dart';
import 'package:child_star/routes/user/mine_index.dart';
import 'package:flutter/widgets.dart';

abstract class IRoutersNavigate {
  ///跳转到主页[MainPage]
  navigateToMain(BuildContext context);

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
}
