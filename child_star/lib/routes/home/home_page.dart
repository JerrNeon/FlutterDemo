import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/my_systems.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/routes/home/home_attention_page.dart';
import 'package:child_star/routes/home/home_community_page.dart';
import 'package:child_star/routes/home/home_new_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  var _currentIndex = 0;
  var _list = [];
  final PageController _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _list
      ..add(HomeNewPage())
      ..add(HomeAttentionPage())
      ..add(HomeCommunityPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _TopBarWidget(
            _currentIndex,
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
          ),
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: _list.length,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      if (_currentIndex != index) {
                        _currentIndex = index;
                      }
                    });
                  },
                  itemBuilder: (context, index) {
                    return _list[index];
                  })),
        ],
      ),
    );
  }
}

class _TopBarWidget extends StatelessWidget {
  final _currentIndex;
  final ValueChanged<int> onTap;

  _TopBarWidget(this._currentIndex, {this.onTap});

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Image(image: MyImages.ic_home_personal), onPressed: () {}),
        DecoratedBox(
          decoration: BoxDecoration(
            color: MyColors.c_f7f7f7,
            borderRadius: BorderRadius.circular(MySizes.s_12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTopMenu(gm.homeNewTitle, 0),
              _buildTopMenu(gm.homeAttentionTitle, 1),
              _buildTopMenu(gm.homeCommunityTitle, 2),
            ],
          ),
        ),
        IconButton(
            icon: Image(image: MyImages.ic_home_message), onPressed: () {}),
      ],
    );
  }

  Widget _buildTopMenu(String text, int index) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _currentIndex == index ? MyColors.c_ffa2b1 : MyColors.c_f7f7f7,
          borderRadius: BorderRadius.circular(MySizes.s_12),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MySizes.s_18, vertical: MySizes.s_4),
            child: Text(
              text,
              style: TextStyle(
                  color:
                      _currentIndex == index ? Colors.white : MyColors.c_a4a4a4,
                  fontSize: MyFontSizes.s_15),
            )),
      ),
      behavior: HitTestBehavior.opaque, //点击padding区域也有效
      onTap: () {
        if (onTap != null) {
          onTap(index);
        }
      },
    );
  }
}
