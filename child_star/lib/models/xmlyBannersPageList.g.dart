// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xmlyBannersPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XmlyBannersPageList _$XmlyBannersPageListFromJson(Map<String, dynamic> json) {
  return XmlyBannersPageList()
    ..totalPage = json['total_page'] as int
    ..totalCount = json['total_count'] as int
    ..currentPage = json['current_page'] as int
    ..banners = (json['banners'] as List)
        ?.map((e) =>
            e == null ? null : XmlyBanners.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$XmlyBannersPageListToJson(
        XmlyBannersPageList instance) =>
    <String, dynamic>{
      'total_page': instance.totalPage,
      'total_count': instance.totalCount,
      'current_page': instance.currentPage,
      'banners': instance.banners
    };
