// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author()
    ..articles = json['articles'] as num
    ..backgroundUrl = json['backgroundUrl'] as String
    ..createTime = json['createTime'] as String
    ..fans = json['fans'] as num
    ..headUrl = json['headUrl'] as String
    ..id = json['id'] as num
    ..introduction = json['introduction'] as String
    ..name = json['name'] as String
    ..tag = json['tag'] as String
    ..updateTime = json['updateTime'] as String
    ..isConcern = json['isConcern'] as bool
    ..infoList = (json['infoList'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'articles': instance.articles,
      'backgroundUrl': instance.backgroundUrl,
      'createTime': instance.createTime,
      'fans': instance.fans,
      'headUrl': instance.headUrl,
      'id': instance.id,
      'introduction': instance.introduction,
      'name': instance.name,
      'tag': instance.tag,
      'updateTime': instance.updateTime,
      'isConcern': instance.isConcern,
      'infoList': instance.infoList
    };
