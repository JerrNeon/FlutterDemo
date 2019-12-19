// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course()
    ..authorId = json['authorId'] as num
    ..cId = json['cId'] as num
    ..createdAt = json['createdAt'] as String
    ..headUrl = json['headUrl'] as String
    ..id = json['id'] as num
    ..instruction = json['instruction'] as String
    ..isDelete = json['isDelete'] as num
    ..mediaTime = json['mediaTime'] as String
    ..mediaUrl = json['mediaUrl'] as String
    ..partHeadUrl = json['partHeadUrl'] as String
    ..partName = json['partName'] as String
    ..partNo = json['partNo'] as num
    ..sNo = json['sNo'] as String
    ..title = json['title'] as String
    ..type = json['type'] as num
    ..updatedAt = json['updatedAt'] as String
    ..isLock = json['isLock'] as bool
    ..watch = json['watch'] as num;
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'cId': instance.cId,
      'createdAt': instance.createdAt,
      'headUrl': instance.headUrl,
      'id': instance.id,
      'instruction': instance.instruction,
      'isDelete': instance.isDelete,
      'mediaTime': instance.mediaTime,
      'mediaUrl': instance.mediaUrl,
      'partHeadUrl': instance.partHeadUrl,
      'partName': instance.partName,
      'partNo': instance.partNo,
      'sNo': instance.sNo,
      'title': instance.title,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'isLock': instance.isLock,
      'watch': instance.watch
    };
