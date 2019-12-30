// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myCollection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCollection _$MyCollectionFromJson(Map<String, dynamic> json) {
  return MyCollection()
    ..cid = json['cid'] as num
    ..createdAt = json['createdAt'] as String
    ..headUrl = json['headUrl'] as String
    ..introduction = json['introduction'] as String
    ..title = json['title'] as String
    ..type = json['type'] as num
    ..uid = json['uid'] as num;
}

Map<String, dynamic> _$MyCollectionToJson(MyCollection instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'createdAt': instance.createdAt,
      'headUrl': instance.headUrl,
      'introduction': instance.introduction,
      'title': instance.title,
      'type': instance.type,
      'uid': instance.uid
    };
