import 'package:child_star/common/resource_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/date_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class CourseItemWidget extends StatelessWidget {
  final Course data;
  final int partNum;
  final GestureTapCallback onTap;

  const CourseItemWidget(
    this.data,
    this.partNum, {
    Key key,
    this.onTap,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_12,
          vertical: MySizes.s_14,
        ),
        child: Row(
          children: <Widget>[
            _buildPartWidget(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MySizes.s_10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColors.c_686868,
                        fontSize: MyFontSizes.s_12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PaddingWidget(
                      top: MySizes.s_6,
                      child: Row(
                        children: <Widget>[
                          Image(image: MyImages.ic_course_time),
                          Text(
                            DateUtils.formatDateMs(
                              int.tryParse(data.mediaTime) ?? 0 * 1000,
                              format: DataFormats.m_s,
                            ),
                            style: TextStyle(
                              color: MyColors.c_b1b1b1,
                              fontSize: MyFontSizes.s_8,
                            ),
                          ),
                          PaddingWidget(
                            left: MySizes.s_4,
                            child: Image(image: MyImages.ic_course_playnum),
                          ),
                          Text(
                            data.watch.toString(),
                            style: TextStyle(
                              color: MyColors.c_b1b1b1,
                              fontSize: MyFontSizes.s_8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image(
              image: MyImagesMultiple.course_status[data.isLock],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartWidget() {
    if (partNum > 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            data.sNo < 10 ? "C0${data.sNo}" : "C${data.sNo}",
            style: TextStyle(
              color: MyColors.c_f99fae,
              fontSize: MyFontSizes.s_10,
            ),
          ),
          DividerWidget(color: MyColors.c_f99fae, width: MySizes.s_18),
          Text(
            "Part${data.partNo}",
            style: TextStyle(
              color: MyColors.c_f99fae,
              fontSize: MyFontSizes.s_8,
            ),
          ),
        ],
      );
    } else {
      return Text(
        "Part${data.partNo}",
        style: TextStyle(
          color: MyColors.c_f99fae,
          fontSize: MyFontSizes.s_8,
        ),
      );
    }
  }
}

class CourseCommentWidget extends StatelessWidget {
  final CourseComment data;

  const CourseCommentWidget(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: MySizes.s_10,
        top: MySizes.s_18,
        right: MySizes.s_20,
        bottom: MySizes.s_18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          loadImage(
            data.headUrl,
            width: MySizes.s_46,
            height: MySizes.s_46,
            shape: BoxShape.circle,
          ),
          Expanded(
            child: PaddingWidget(
              left: MySizes.s_8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        data.nickName,
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateUtils.formatDateStr(
                          data.createdAt,
                          format: DataFormats.y_mo_d,
                        ),
                        style: TextStyle(
                          color: MyColors.c_777777,
                          fontSize: MyFontSizes.s_12,
                        ),
                      ),
                    ],
                  ),
                  PaddingWidget(
                    top: MySizes.s_10,
                    child: Text(
                      data.content,
                      style: TextStyle(
                        color: MyColors.c_777777,
                        fontSize: MyFontSizes.s_12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
