import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/routes/home/home_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
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
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Image(image: MyImages.ic_home_personal),
                  onPressed: () => RoutersNavigate().navigateToMine(context)),
              HomeTopBarWidget(
                currentIndex: _currentIndex,
                data: [
                  gm.homeNewTitle,
                  gm.homeAttentionTitle,
                  gm.homeCommunityTitle,
                ],
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
              ),
              IconButton(
                  icon: Image(image: MyImages.ic_home_message),
                  onPressed: () {}),
            ],
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
