// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return Lecture()
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
    ..isNew = json['isNew'] as bool;
}

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
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
      'isNew': instance.isNew
    };
