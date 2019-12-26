import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WikiItemWidget extends StatelessWidget {
  final News data;
  final GestureTapCallback onTap;

  const WikiItemWidget({
    Key key,
    @required this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          onTap ??
          RoutersNavigate().navigateToNewDetail(context, data.id.toString()),
      child: Padding(
        padding: EdgeInsets.only(
            left: MySizes.s_10,
            top: MySizes.s_9,
            right: MySizes.s_14,
            bottom: MySizes.s_4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            loadImage(
              data.headUrl,
              width: MySizes.s_60,
              height: MySizes.s_60,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(MySizes.s_4),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      style: TextStyle(
                        color: MyColors.c_686868,
                        fontSize: MyFontSizes.s_12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: MySizes.s_6),
                      child: Text(
                        "${data.lookRecord}${GmLocalizations.of(context).consultationBrowseNumTitle}",
                        style: TextStyle(
                          color: MyColors.c_929292,
                          fontSize: MyFontSizes.s_10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image(
              image: MyImages.ic_mine_arrow,
            ),
          ],
        ),
      ),
    );
  }
}

class InquiryDialog extends StatelessWidget {
  final GestureTapCallback onBuyTap;
  final GestureTapCallback onForwardTap;

  const InquiryDialog({Key key, this.onBuyTap, this.onForwardTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return UnconstrainedBox(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: MySizes.s_240,
            margin: EdgeInsets.only(top: MySizes.s_12, right: MySizes.s_11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(MySizes.s_4),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: MySizes.s_80),
                Text(
                  gm.inquiryDialogContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.c_686868,
                    fontSize: MyFontSizes.s_15,
                    fontWeight: FontWeight.bold,
                    wordSpacing: MySizes.s_4,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: MySizes.s_40),
                Divider(
                  color: MyColors.c_777777,
                  height: MySizes.s_1,
                ),
                SizedBox(height: MySizes.s_20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onBuyTap != null) {
                      onBuyTap();
                    }
                  },
                  child: Container(
                    width: MySizes.s_180,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: MySizes.s_20),
                    padding: EdgeInsets.symmetric(vertical: MySizes.s_8),
                    decoration: BoxDecoration(
                      color: MyColors.c_6eabb4,
                      borderRadius: BorderRadius.circular(MySizes.s_20),
                    ),
                    child: Text(
                      gm.inquiryDialogPositive,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MyFontSizes.s_15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MySizes.s_12),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onForwardTap != null) {
                      onForwardTap();
                    }
                  },
                  child: Container(
                    width: MySizes.s_180,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: MySizes.s_20),
                    padding: EdgeInsets.symmetric(vertical: MySizes.s_8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(MySizes.s_20),
                      border: Border.all(
                        color: MyColors.c_9f9f9f,
                        width: MySizes.s_2,
                      ),
                    ),
                    child: Text(
                      gm.inquiryDialogNegative,
                      style: TextStyle(
                        color: MyColors.c_9f9f9f,
                        fontSize: MyFontSizes.s_15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MySizes.s_30),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Image(
                image: MyImages.ic_consultation_close,
              ),
            ),
          )
        ],
      ),
    );
  }
}
