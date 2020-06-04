// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xmlyBanners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XmlyBanners _$XmlyBannersFromJson(Map<String, dynamic> json) {
  return XmlyBanners()
    ..id = json['id'] as num
    ..bannerTitle = json['banner_title'] as String
    ..bannerCoverUrl = json['banner_cover_url'] as String
    ..shortTitle = json['short_title'] as String
    ..bannerContentType = json['banner_content_type'] as int
    ..isPaid = json['is_paid'] as int
    ..operationCategoryId = json['operation_category_id'] as int
    ..bannerContentId = json['banner_content_id'] as int
    ..bannerContentTitle = json['banner_content_title'] as String
    ..redirectUrl = json['redirect_url'] as String
    ..createdAt = json['created_at'] as num
    ..updatedAt = json['updated_at'] as num
    ..kind = json['kind'] as String;
}

Map<String, dynamic> _$XmlyBannersToJson(XmlyBanners instance) =>
    <String, dynamic>{
      'id': instance.id,
      'banner_title': instance.bannerTitle,
      'banner_cover_url': instance.bannerCoverUrl,
      'short_title': instance.shortTitle,
      'banner_content_type': instance.bannerContentType,
      'is_paid': instance.isPaid,
      'operation_category_id': instance.operationCategoryId,
      'banner_content_id': instance.bannerContentId,
      'banner_content_title': instance.bannerContentTitle,
      'redirect_url': instance.redirectUrl,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'kind': instance.kind
    };
