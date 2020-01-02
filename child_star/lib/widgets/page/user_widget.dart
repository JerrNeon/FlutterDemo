import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModifyAvatarWidget extends StatelessWidget {
  final GestureTapCallback onCameraTap;
  final GestureTapCallback onAlbumTap;

  const ModifyAvatarWidget({Key key, this.onCameraTap, this.onAlbumTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return CupertinoActionSheet(
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (onCameraTap != null) {
              onCameraTap();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: MySizes.s_20),
            child: Text(
              gm.modifyUserInfoDialogCamera,
              style: TextStyle(
                color: Colors.blue,
                fontSize: MyFontSizes.s_14,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (onAlbumTap != null) {
              onAlbumTap();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: MySizes.s_20),
            child: Text(
              gm.modifyUserInfoDialogAlbum,
              style: TextStyle(
                color: Colors.blue,
                fontSize: MyFontSizes.s_14,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
      cancelButton: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: MySizes.s_14),
          child: Text(
            gm.modifyUserInfoDialogCancel,
            style: TextStyle(
              color: MyColors.c_686868,
              fontSize: MyFontSizes.s_14,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
