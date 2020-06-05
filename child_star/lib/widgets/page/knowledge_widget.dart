import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/date_utils.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';

class LectureItemWidget extends StatelessWidget {
  final Lecture data;
  final GestureTapCallback onTap;

  const LectureItemWidget({Key key, this.data, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => RoutersNavigate()
              .navigateToLectureDetail(context, data.id.toString()),
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: MySizes.s_4),
        child: Row(
          children: <Widget>[
            loadImage(
              data.headUrl,
              width: MySizes.s_144,
              height: MySizes.s_88,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(MySizes.s_4),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: MySizes.s_5,
                      right: MySizes.s_5,
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Offstage(
                        offstage: !data.isNew,
                        child: Image(
                          image: MyImages.ic_lecture_new,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: MySizes.s_12,
                      right: MySizes.s_5,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: MySizes.s_6,
                            ),
                            child: Text(
                              data.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: MyColors.c_686868,
                                fontSize: MyFontSizes.s_12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            data.descr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MyColors.c_686868,
                              fontSize: MyFontSizes.s_12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: MySizes.s_8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: MyColors.c_efefef,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(MySizes.s_14),
                            bottomLeft: Radius.circular(MySizes.s_14),
                          ),
                        ),
                        child: _buildPrice(data),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPrice(Lecture data) {
    if (data.price != 0) {
      return Padding(
        padding: EdgeInsets.only(
          left: MySizes.s_8,
          top: MySizes.s_2,
          right: MySizes.s_3,
          bottom: MySizes.s_2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: MySizes.s_6),
              child: Text(
                "${data.price}",
                style: TextStyle(
                  color: MyColors.c_7c7c7c,
                  fontSize: MyFontSizes.s_12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image(
              image: MyImages.ic_mine_point,
              width: MySizes.s_11,
              height: MySizes.s_11,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_8,
          vertical: MySizes.s_2,
        ),
        child: Text(
          "VIP",
          style: TextStyle(
            color: MyColors.c_7c7c7c,
            fontSize: MyFontSizes.s_12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}

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
      onTap: () {
        if (data.isLock) {
          showToast(GmLocalizations.of(context).lectureBuyToast);
          return;
        }
        if (onTap != null) {
          onTap();
        }
      },
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
                            TimeUtils.formatDateS(data.mediaTime),
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
        data.sNo < 10 ? "C0${data.sNo}" : "C${data.sNo}",
        style: TextStyle(
          color: MyColors.c_f99fae,
          fontSize: MyFontSizes.s_10,
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

class AdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MySizes.s_4),
      child: Image(
        width: double.infinity,
        image: MyImages.ic_mine_banner,
        fit: BoxFit.cover,
      ),
    );
  }
}

class XmlyPlayCountWidget extends StatelessWidget {
  final int playCount;

  const XmlyPlayCountWidget({
    Key key,
    @required this.playCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MySizes.s_4,
        vertical: MySizes.s_5,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(topRight: Radius.circular(MySizes.s_3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(image: MyImages.ic_xmly_playcount),
          SizedBox(width: MySizes.s_3),
          Text(
            NumberUtils.getPlayCount(context, playCount),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
