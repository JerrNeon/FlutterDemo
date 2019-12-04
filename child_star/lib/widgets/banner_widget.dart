import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/encode_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatelessWidget {
  final List<Banners> imageList;
  final double aspectRatio;
  final SwiperOnTap onTap;

  static const String VIDEO = "video";
  static const String AUDIO = "audio";
  static const String CONTENT = "content";
  static const String H5 = "H5";
  static const String INNER = "inner";
  static const String SPRINGRAIN = "springrain";
  static const String COURSE = "course";

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
        onTap:
            onTap ?? (index) => _handlerBannerClick(context, imageList[index]),
        itemBuilder: (context, index) {
          return Image.network(
            imageList[index].kvUrl,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  _handlerBannerClick(BuildContext context, Banners banners) {
    switch (banners.elementType) {
      case VIDEO:
        break;
      case AUDIO:
        break;
      case CONTENT:
        break;
      case H5:
        RoutersNavigate().navigateToH5(context, encodeStringToBase64UrlSafeString(banners.params));
        break;
      case INNER:
        break;
      case SPRINGRAIN:
        break;
      case COURSE:
        break;
      default:
        break;
    }
  }
}
