// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecturePart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LecturePart _$LecturePartFromJson(Map<String, dynamic> json) {
  return LecturePart()
    ..partHeadUrl = json['partHeadUrl'] as String
    ..partName = json['partName'] as String
    ..partNo = json['partNo'] as num
    ..subjectNum = json['subjectNum'] as num;
}

Map<String, dynamic> _$LecturePartToJson(LecturePart instance) =>
    <String, dynamic>{
      'partHeadUrl': instance.partHeadUrl,
      'partName': instance.partName,
      'partNo': instance.partNo,
      'subjectNum': instance.subjectNum
    };
