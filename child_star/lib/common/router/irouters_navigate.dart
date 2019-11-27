import 'package:flutter/widgets.dart';

abstract class IRoutersNavigate {
  ///跳转到主页@MainPage
  navigateToMain(BuildContext context);

  ///跳转到首页-搜索界面@HomeSearchPage
  navigateToHomeSearch(BuildContext context);
}
