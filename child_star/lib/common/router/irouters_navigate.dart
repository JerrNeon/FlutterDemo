import 'package:child_star/routes/home/h5_page.dart';
import 'package:child_star/routes/home/home_search_page.dart';
import 'package:child_star/routes/home/new_detail_page.dart';
import 'package:child_star/routes/main_page.dart';
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
}
