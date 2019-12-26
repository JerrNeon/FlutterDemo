// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wikiTagList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WikiTagList _$WikiTagListFromJson(Map<String, dynamic> json) {
  return WikiTagList()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WikiTagListToJson(WikiTagList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': instance.tags
    };
