import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/models_index.dart';
import 'package:child_star/utils/utils_index.dart';
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

class DownloadItemWidget extends StatelessWidget {
  final MediaCache data;
  final GestureTapCallback onItemTap;
  final GestureTapCallback onDeleteTap;

  const DownloadItemWidget(
      {Key key, @required this.data, this.onItemTap, this.onDeleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(
          left: MySizes.s_16,
          right: MySizes.s_20,
          bottom: MySizes.s_14,
        ),
        child: Row(
          children: <Widget>[
            loadImage(
              data.imageUrl,
              width: MySizes.s_118,
              height: MySizes.s_80,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(MySizes.s_4),
            ),
            SizedBox(width: MySizes.s_16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.c_8c8c8c,
                      fontSize: MyFontSizes.s_14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MySizes.s_4),
                  Text(
                    data.desc,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: MyColors.c_8c8c8c,
                      fontSize: MyFontSizes.s_14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: MySizes.s_10),
            GestureDetector(
              onTap: onDeleteTap,
              child: Image(
                image: MyImages.ic_download_delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
