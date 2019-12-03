import 'package:cached_network_image/cached_network_image.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(
  String imageUrl, {
  double borderRadius,
  Size placeholderSize = const Size(MySizes.s_100, MySizes.s_100),
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) {
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
      },
      errorWidget: (context, url, error) {
        return Container(
          color: Colors.grey[400],
        );
      },
    ),
  );
}
