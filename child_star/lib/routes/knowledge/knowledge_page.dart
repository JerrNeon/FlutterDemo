import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/routes/knowledge/knowledge_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:flutter/material.dart';

class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage>
    with AutomaticKeepAliveClientMixin {
  var _currentIndex = 0;
  var _list = [];
  final PageController _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _list..add(RoomPage())..add(LecturePage())..add(XmlyPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: MySizes.s_14),
              child: HomeTopBarWidget(
                currentIndex: _currentIndex,
                data: [
                  gm.knowledgeRoomTitle,
                  gm.knowledgeLectureTitle,
                  gm.knowledgeXmlyTitle,
                ],
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
              ),
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
                  itemBuilder: (context, index) => _list[index]),
            ),
          ],
        ),
      ),
    );
  }
}
