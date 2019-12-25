import 'dart:core';

import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
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
      case AUDIO:
      case CONTENT:
        RoutersNavigate().navigateToNewDetail(context, banners.params);
        break;
      case H5:
        RoutersNavigate().navigateToH5(context, banners.params);
        break;
      case INNER: //我的会员界面
        break;
      case SPRINGRAIN: //春雨医生
        break;
      case COURSE: //讲堂详情
        RoutersNavigate().navigateToLectureDetail(context, banners.params);
        break;
      default:
        break;
    }
  }
}

class AdvertisementWidget extends StatelessWidget {
  final Banners banners;
  final double width;
  final double height;
  final BoxFit fit;
  final GestureTapCallback onTap;

  const AdvertisementWidget({
    Key key,
    this.banners,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => handlerBannerClick(context),
      child: loadImage(
        banners.kvUrl,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  handlerBannerClick(BuildContext context) {
    switch (banners.elementType) {
      case BannerWidget.VIDEO:
      case BannerWidget.AUDIO:
      case BannerWidget.CONTENT:
        RoutersNavigate().navigateToNewDetail(context, banners.params);
        break;
      case BannerWidget.H5:
        RoutersNavigate().navigateToH5(context, banners.params);
        break;
      case BannerWidget.INNER: //我的会员界面
        break;
      case BannerWidget.SPRINGRAIN: //春雨医生
        break;
      case BannerWidget.COURSE: //讲堂详情
        RoutersNavigate().navigateToLectureDetail(context, banners.params);
        break;
      default:
        break;
    }
  }
}
