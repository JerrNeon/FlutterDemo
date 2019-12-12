import 'package:child_star/common/my_sizes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(
  String imageUrl, {
  double borderRadius = 0.0,
  bool isCircle = false,
  double width,
  double height,
  BoxFit fit,
  Size placeholderSize = const Size(MySizes.s_100, MySizes.s_100),
}) {
  if (isCircle) {
    return ClipOval(
      child: _buildCachedNetworkImage(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholderSize: placeholderSize,
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _buildCachedNetworkImage(imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholderSize: placeholderSize),
    );
  }
}

Widget _buildCachedNetworkImage(
  String imageUrl, {
  double borderRadius = 0.0,
  double width,
  double height,
  BoxFit fit = BoxFit.cover,
  Size placeholderSize = const Size(MySizes.s_100, MySizes.s_100),
}) {
  return ExtendedImage.network(
    imageUrl,
    width: width,
    height: height,
    fit: fit,
    loadStateChanged: (ExtendedImageState state) {
      if (state.extendedImageLoadState == LoadState.loading) {
        return Container(
          width: placeholderSize.width,
          height: placeholderSize.height,
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
