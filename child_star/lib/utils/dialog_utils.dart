import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg,
    {Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(msg: msg, toastLength: toastLength, gravity: gravity);
}

showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future showCupertinoAlertDialog(
  BuildContext context, {
  String title,
  @required String content,
  String negativeTitle,
  String positiveTitle,
  GestureTapCallback onNegativeTap,
  GestureTapCallback onPositiveTap,
}) async {
  assert(context != null);
  GmLocalizations gm = GmLocalizations.of(context);
  if (title == null) title = gm.dialogTipsTitle;
  if (negativeTitle == null) negativeTitle = gm.dialogNagativeTitle;
  if (positiveTitle == null) positiveTitle = gm.dialogPositiveTitle;
  return await showCupertinoDialog<int>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: MyColors.c_686868,
              fontSize: MyFontSizes.s_18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              color: MyColors.c_686868,
              fontSize: MyFontSizes.s_15,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                if (onNegativeTap != null) {
                  onNegativeTap();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: MySizes.s_40,
                alignment: Alignment.center,
                child: Text(
                  negativeTitle,
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: MyFontSizes.s_16,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                if (onPositiveTap != null) {
                  onPositiveTap();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: MySizes.s_40,
                alignment: Alignment.center,
                child: Text(
                  positiveTitle,
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: MyFontSizes.s_16,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        );
      });
}
