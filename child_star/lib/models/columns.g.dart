// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'columns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Columns _$ColumnsFromJson(Map<String, dynamic> json) {
  return Columns()
    ..id = json['id'] as num
    ..createdAt = json['created_at'] as num
    ..updatedAt = json['updated_at'] as num
    ..title = json['title'] as String
    ..coverUrlSmall = json['cover_url_small'] as String
    ..coverUrlMiddle = json['cover_url_middle'] as String
    ..coverUrlLarge = json['cover_url_large'] as String
    ..contentType = json['content_type'] as int
    ..contentNum = json['content_num'] as int
    ..kind = json['kind'] as String;
}

Map<String, dynamic> _$ColumnsToJson(Columns instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'title': instance.title,
      'cover_url_small': instance.coverUrlSmall,
      'cover_url_middle': instance.coverUrlMiddle,
      'cover_url_large': instance.coverUrlLarge,
      'content_type': instance.contentType,
      'content_num': instance.contentNum,
      'kind': instance.kind
    };
