import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///资讯点赞、收藏、评论、下载Widget 互动
class NewsInteractionWidget extends StatelessWidget {
  final String like;
  final String collect;
  final String comment;

  NewsInteractionWidget({
    this.like,
    this.collect,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(height: MySizes.s_1, color: MyColors.c_d5d5d5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MySizes.s_10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildItem(MyImages.ic_newdetail_like, like),
                _buildItem(MyImages.ic_newdetail_collection, collect),
                _buildItem(MyImages.ic_newdetail_comment, comment),
                _buildItem(MyImages.ic_newdetail_download,
                    GmLocalizations.of(context).newDetailDownloadTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(AssetImage image, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(image: image),
        Padding(padding: EdgeInsets.only(left: MySizes.s_8)),
        Text(
          text,
          style:
              TextStyle(color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
        ),
      ],
    );
  }
}

class NewsItemWidget extends StatelessWidget {
  final News data;

  const NewsItemWidget(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MySizes.s_24, right: MySizes.s_16, bottom: MySizes.s_14),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              loadImage(
                data.headUrl,
                borderRadius: BorderRadius.circular(MySizes.s_3),
                width: MySizes.s_155,
                height: MySizes.s_105,
                fit: BoxFit.cover,
              ),
              data.mediaTime.isEmpty
                  ? EmptyWidget()
                  : Positioned(
                      right: MySizes.s_4,
                      bottom: MySizes.s_4,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: MySizes.s_8, vertical: MySizes.s_4),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(MySizes.s_3),
                        ),
                        child: Text(
                          TimeUtils.formatDateS(data.mediaTime),
                          style: TextStyle(
                              color: MyColors.c_777777,
                              fontSize: MyFontSizes.s_10),
                        ),
                      ),
                    ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: MySizes.s_14),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: MySizes.s_104),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: MySizes.s_8)),
                    Text(
                      "#${data.innerWord}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors.c_777777, fontSize: MyFontSizes.s_12),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
