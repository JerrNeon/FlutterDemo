// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner()
    ..kvUrl = json['kvUrl'] as String
    ..params = json['params'] as String
    ..elementType = json['elementType'] as String
    ..shareTitle = json['shareTitle'] as String
    ..shareDesc = json['shareDesc'] as String;
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'kvUrl': instance.kvUrl,
      'params': instance.params,
      'elementType': instance.elementType,
      'shareTitle': instance.shareTitle,
      'shareDesc': instance.shareDesc
    };
