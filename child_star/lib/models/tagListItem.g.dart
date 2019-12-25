// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagListItem _$TagListItemFromJson(Map<String, dynamic> json) {
  return TagListItem()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TagListItemToJson(TagListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags
    };
