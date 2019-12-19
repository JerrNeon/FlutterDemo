// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courseComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseComment _$CourseCommentFromJson(Map<String, dynamic> json) {
  return CourseComment()
    ..cId = json['cId'] as num
    ..cTitle = json['cTitle'] as String
    ..content = json['content'] as String
    ..createdAt = json['createdAt'] as String
    ..headUrl = json['headUrl'] as String
    ..id = json['id'] as num
    ..nickName = json['nickName'] as String
    ..parentId = json['parentId'] as num
    ..partNo = json['partNo'] as num
    ..replyId = json['replyId'] as num
    ..replyName = json['replyName'] as String
    ..sId = json['sId'] as num
    ..sNo = json['sNo'] as String
    ..sTitle = json['sTitle'] as String
    ..uid = json['uid'] as num
    ..replyList = (json['replyList'] as List)
        ?.map((e) =>
            e == null ? null : CourseReply.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CourseCommentToJson(CourseComment instance) =>
    <String, dynamic>{
      'cId': instance.cId,
      'cTitle': instance.cTitle,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'headUrl': instance.headUrl,
      'id': instance.id,
      'nickName': instance.nickName,
      'parentId': instance.parentId,
      'partNo': instance.partNo,
      'replyId': instance.replyId,
      'replyName': instance.replyName,
      'sId': instance.sId,
      'sNo': instance.sNo,
      'sTitle': instance.sTitle,
      'uid': instance.uid,
      'replyList': instance.replyList
    };
