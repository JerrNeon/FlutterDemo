// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myCourse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCourse _$MyCourseFromJson(Map<String, dynamic> json) {
  return MyCourse()
    ..authorId = json['authorId'] as num
    ..descr = json['descr'] as String
    ..headUrl = json['headUrl'] as String
    ..headUrlList = json['headUrlList'] as String
    ..id = json['id'] as num
    ..price = json['price'] as num
    ..title = json['title'] as String;
}

Map<String, dynamic> _$MyCourseToJson(MyCourse instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'descr': instance.descr,
      'headUrl': instance.headUrl,
      'headUrlList': instance.headUrlList,
      'id': instance.id,
      'price': instance.price,
      'title': instance.title
    };
