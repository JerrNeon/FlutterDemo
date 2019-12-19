// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lectureDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureDetail _$LectureDetailFromJson(Map<String, dynamic> json) {
  return LectureDetail()
    ..auditAt = json['auditAt'] as String
    ..auditor = json['auditor'] as String
    ..authorId = json['authorId'] as num
    ..content = json['content'] as String
    ..createdAt = json['createdAt'] as String
    ..descr = json['descr'] as String
    ..headUrl = json['headUrl'] as String
    ..headUrlList = json['headUrlList'] as String
    ..id = json['id'] as num
    ..instruction = json['instruction'] as String
    ..lecturerHeadUrl = json['lecturerHeadUrl'] as String
    ..lecturerInstruction = json['lecturerInstruction'] as String
    ..lecturerName = json['lecturerName'] as String
    ..price = json['price'] as num
    ..sales = json['sales'] as num
    ..status = json['status'] as num
    ..title = json['title'] as String
    ..updatedAt = json['updatedAt'] as String
    ..weight = json['weight'] as num
    ..like = json['like'] as num
    ..comment = json['comment'] as num
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..parts = (json['parts'] as List)
        ?.map((e) =>
            e == null ? null : LecturePart.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..partNum = json['partNum'] as num
    ..isLock = json['isLock'] as bool
    ..lookNum = json['lookNum'] as num;
}

Map<String, dynamic> _$LectureDetailToJson(LectureDetail instance) =>
    <String, dynamic>{
      'auditAt': instance.auditAt,
      'auditor': instance.auditor,
      'authorId': instance.authorId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'descr': instance.descr,
      'headUrl': instance.headUrl,
      'headUrlList': instance.headUrlList,
      'id': instance.id,
      'instruction': instance.instruction,
      'lecturerHeadUrl': instance.lecturerHeadUrl,
      'lecturerInstruction': instance.lecturerInstruction,
      'lecturerName': instance.lecturerName,
      'price': instance.price,
      'sales': instance.sales,
      'status': instance.status,
      'title': instance.title,
      'updatedAt': instance.updatedAt,
      'weight': instance.weight,
      'like': instance.like,
      'comment': instance.comment,
      'tags': instance.tags,
      'parts': instance.parts,
      'partNum': instance.partNum,
      'isLock': instance.isLock,
      'lookNum': instance.lookNum
    };
