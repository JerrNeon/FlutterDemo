import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/widgets/page/page_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class XmlySearchPage extends StatefulWidget {
  @override
  _XmlySearchPageState createState() => _XmlySearchPageState();
}

class _XmlySearchPageState extends State<XmlySearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _keyword;
  VoidCallback _listener;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    //设置状态栏透明
    SystemChrome.setSystemUIOverlayStyle(MySystems.dark);
    _listener = () {
      if (_keyword != null &&
          _keyword.isNotEmpty &&
          _textEditingController.text.isEmpty) {
        if (mounted) {
          _isVisible = false;
          setState(() {});
        }
      }
    };
    _textEditingController.addListener(_listener);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      backgroundColor: MyColors.c_f0f0f0,
      appBar: MySystems.noAppBarPreferredSize,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: HomeSearchWidget(
              controller: _textEditingController,
              hintText: gm.xmlySearchHint,
              onSubmitted: (s) {
                if (mounted) {
                  _keyword = s;
                  _isVisible = true;
                  setState(() {});
                }
              },
            ),
          ),
          Expanded(
            child: Visibility(
              visible: _isVisible,
              child: SmartRefresherWidget<Album>.listSeparated(
                onRefreshLoading: (pageIndex) => _search(pageIndex),
                listItemBuilder: (context, index, album) =>
                    XmlyAlbumWidget(data: album),
                listSeparatorBuilder: (context, index, album) =>
                    SizedBox(height: MySizes.s_12),
                listPadding: EdgeInsets.only(top: MySizes.s_12),
                isShowNoData: false,
                enablePullDown: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<PageList<Album>> _search(int pageIndex) async {
    PageList<Album> pageList = PageList();
    AlbumPageList albumPageList = await XmlyNetManager()
        .getCollectedAlbumList(albumTitle: _keyword, page: pageIndex);
    if (albumPageList != null) {
      pageList.pageNum = albumPageList.currentPage;
      pageList.totalNum = albumPageList.totalCount;
      pageList.resultList = albumPageList.albums;
    }
    return pageList;
  }
}
