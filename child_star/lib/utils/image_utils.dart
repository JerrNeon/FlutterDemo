import 'package:child_star/common/my_sizes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Widget loadImage(
  String imageUrl, {
  double width,
  double height,
  Color color,
  BoxFit fit = BoxFit.cover,
  BoxBorder border,
  BoxShape shape,
  BorderRadiusGeometry borderRadius,
  double loadingWidth = MySizes.s_100,
  double loadingHeight = MySizes.s_100,
}) {
  return ExtendedImage.network(
    imageUrl,
    width: width,
    height: height,
    fit: fit,
    border: border,
    shape: shape,
    borderRadius: borderRadius,
    loadStateChanged: (ExtendedImageState state) {
      if (state.extendedImageLoadState == LoadState.loading) {
        return Container(
          width: loadingWidth,
          height: loadingHeight,
          child: UnconstrainedBox(
            child: SizedBox(
              width: MySizes.s_20,
              height: MySizes.s_20,
              child: CircularProgressIndicator(strokeWidth: MySizes.s_1),
            ),
          ),
        );
      } else if (state.extendedImageLoadState == LoadState.failed) {
        return Container(
          color: Colors.grey[400],
        );
      } else {
        return null;
      }
    },
  );
}
