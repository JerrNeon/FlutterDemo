import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(String imageUrl, {double borderRadius}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) {
        return CircularProgressIndicator();
      },
      errorWidget: (context, url, error) {
        return Container(
          color: Colors.grey[400],
        );
      },
    ),
  );
}
