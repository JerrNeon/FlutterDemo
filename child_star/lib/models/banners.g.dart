// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banners _$BannersFromJson(Map<String, dynamic> json) {
  return Banners()
    ..kvUrl = json['kvUrl'] as String
    ..params = json['params'] as String
    ..elementType = json['elementType'] as String
    ..shareTitle = json['shareTitle'] as String
    ..shareDesc = json['shareDesc'] as String;
}

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'kvUrl': instance.kvUrl,
      'params': instance.params,
      'elementType': instance.elementType,
      'shareTitle': instance.shareTitle,
      'shareDesc': instance.shareDesc
    };
