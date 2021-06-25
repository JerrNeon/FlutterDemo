import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/routes/consultation/consultation_page.dart';
import 'package:child_star/routes/exercise/exercise_page.dart';
import 'package:child_star/routes/home/home_page.dart';
import 'package:child_star/routes/knowledge/knowledge_page.dart';
import 'package:child_star/utils/dialog_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/material.dart';
import 'package:xmly/xmly_plugin.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  var _list = [];
  var _pageController = PageController();
  DateTime _lastPressedDateTime; //上次点击时间

  @override
  void initState() {
    StatusBarUtils.showBar();
    StatusBarUtils.setDark();
    _list
      ..add(HomePage())
      ..add(KnowledgePage())
      ..add(ExercisePage())
      ..add(ConsultationPage());
    super.initState();
  }

  @override
  void dispose() {
    Xmly().release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gm = GmLocalizations.of(context);
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _createBottomNavigationBarItem(
                  MyImages.ic_home, MyImages.ic_home_active, gm.homeTitle),
              _createBottomNavigationBarItem(MyImages.ic_knowledge,
                  MyImages.ic_knowledge_active, gm.knowledgeTitle),
              _createBottomNavigationBarItem(MyImages.ic_exercise,
                  MyImages.ic_exercise_active, gm.exerciseTitle),
              _createBottomNavigationBarItem(MyImages.ic_consultation,
                  MyImages.ic_consultation_active, gm.consultationTitle),
            ],
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedLabelStyle:
                TextStyle(color: MyColors.c_929292, fontSize: MyFontSizes.s_11),
            selectedLabelStyle:
                TextStyle(color: MyColors.c_929292, fontSize: MyFontSizes.s_11),
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
          ),
          body: PageView.builder(
              //禁止滑动
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  if (_currentIndex != index) {
                    _currentIndex = index;
                  }
                });
              },
              itemCount: _list.length,
              itemBuilder: (context, index) => _list[index]),
        ),
        onWillPop: () async {
          if (_currentIndex != 0 && _pageController != null) {
            _pageController.jumpToPage(0);
            return false;
          } else if (_lastPressedDateTime == null ||
              DateTime.now().difference(_lastPressedDateTime) >
                  Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedDateTime = DateTime.now();
            showToast(gm.homeExitMessage);
            return false;
          }
          return true;
        });
  }

  BottomNavigationBarItem _createBottomNavigationBarItem(
      AssetImage icon, AssetImage activeIcon, String title) {
    return BottomNavigationBarItem(
      icon: Image(image: icon),
      activeIcon: Image(image: activeIcon),
      label: title,
    );
  }
}
