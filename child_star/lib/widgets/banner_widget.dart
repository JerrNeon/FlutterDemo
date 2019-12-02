import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatelessWidget {
  final List<Banners> imageList;
  final double aspectRatio;
  final SwiperOnTap onTap;

  BannerWidget(this.imageList, {this.aspectRatio = 366.0 / 153.0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Swiper(
        itemCount: imageList.length,
        autoplay: true,
        autoplayDelay: 5000,
        pagination: SwiperPagination(
            margin: EdgeInsets.only(bottom: MySizes.s_6),
            builder: DotSwiperPaginationBuilder(
              activeColor: MyColors.c_ffa2b1,
              color: Colors.white,
              activeSize: MySizes.s_6,
              size: MySizes.s_6,
            )),
        controller: SwiperController(),
        onTap: onTap ?? (index) {},
        itemBuilder: (context, index) {
          return Image.network(
            imageList[index].kvUrl,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
