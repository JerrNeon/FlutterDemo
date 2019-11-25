import 'package:child_star/common/my_colors.dart';
import 'package:child_star/routes/consultation_page.dart';
import 'package:child_star/routes/exercise_page.dart';
import 'package:child_star/routes/home_page.dart';
import 'package:child_star/routes/knowledge_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0;
  var list = List();

  @override
  void initState() {
    list
      ..add(HomePage())
      ..add(KnowledgePage())
      ..add(ExercisePage())
      ..add(ConsultationPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("images/ic_home.png")),
            activeIcon: Image(image: AssetImage("images/ic_home_active.png")),
            title: Text(
              "首页",
              style: TextStyle(color: MyColors.c_92992, fontSize: 11),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("images/ic_knowledge.png")),
            activeIcon:
                Image(image: AssetImage("images/ic_knowledge_active.png")),
            title: Text(
              "知识",
              style: TextStyle(color: MyColors.c_92992, fontSize: 11),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("images/ic_exercise.png")),
            activeIcon:
                Image(image: AssetImage("images/ic_exercise_active.png")),
            title: Text(
              "活动",
              style: TextStyle(color: MyColors.c_92992, fontSize: 11),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage("images/ic_consultation.png")),
            activeIcon:
                Image(image: AssetImage("images/ic_consultation_active.png")),
            title: Text(
              "在线咨询",
              style: TextStyle(color: MyColors.c_92992, fontSize: 11),
            ),
          ),
        ],
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: list[_index],
    );
  }
}
