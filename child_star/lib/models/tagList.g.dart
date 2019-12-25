// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagList _$TagListFromJson(Map<String, dynamic> json) {
  return TagList()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagListItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TagListToJson(TagList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags
    };
