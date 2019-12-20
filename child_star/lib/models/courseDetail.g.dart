// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courseDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetail _$CourseDetailFromJson(Map<String, dynamic> json) {
  return CourseDetail()
    ..authorId = json['authorId'] as num
    ..cId = json['cId'] as num
    ..courseTitle = json['courseTitle'] as String
    ..courseDescr = json['courseDescr'] as String
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
    ..sNo = json['sNo'] as num
    ..title = json['title'] as String
    ..type = json['type'] as num
    ..updatedAt = json['updatedAt'] as String
    ..like = json['like'] as num
    ..collect = json['collect'] as num
    ..comment = json['comment'] as num
    ..isCollect = json['isCollect'] as bool
    ..isLike = json['isLike'] as bool
    ..watch = json['watch'] as num
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CourseDetailToJson(CourseDetail instance) =>
    <String, dynamic>{
      'authorId': instance.authorId,
      'cId': instance.cId,
      'courseTitle': instance.courseTitle,
      'courseDescr': instance.courseDescr,
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
      'like': instance.like,
      'collect': instance.collect,
      'comment': instance.comment,
      'isCollect': instance.isCollect,
      'isLike': instance.isLike,
      'watch': instance.watch,
      'tags': instance.tags
    };
