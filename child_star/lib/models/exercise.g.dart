// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise()
    ..content = json['content'] as String
    ..createdAt = json['createdAt'] as String
    ..descr = json['descr'] as String
    ..downloadUrl = json['downloadUrl'] as String
    ..eTime = json['eTime'] as String
    ..enabled = json['enabled'] as num
    ..headUrl = json['headUrl'] as String
    ..id = json['id'] as num
    ..sTime = json['sTime'] as String
    ..tagId = json['tagId'] as num
    ..tagName = json['tagName'] as String
    ..title = json['title'] as String
    ..type = json['type'] as num
    ..updatedAt = json['updatedAt'] as String
    ..weight = json['weight'] as num
    ..btnName = json['btnName'] as String
    ..tagWord = json['tagWord'] as String
    ..tagWordColor = json['tagWordColor'] as String
    ..jumpUrl = json['jumpUrl'] as String;
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'content': instance.content,
      'createdAt': instance.createdAt,
      'descr': instance.descr,
      'downloadUrl': instance.downloadUrl,
      'eTime': instance.eTime,
      'enabled': instance.enabled,
      'headUrl': instance.headUrl,
      'id': instance.id,
      'sTime': instance.sTime,
      'tagId': instance.tagId,
      'tagName': instance.tagName,
      'title': instance.title,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'weight': instance.weight,
      'btnName': instance.btnName,
      'tagWord': instance.tagWord,
      'tagWordColor': instance.tagWordColor,
      'jumpUrl': instance.jumpUrl
    };
