// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newslist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Newslist _$NewslistFromJson(Map<String, dynamic> json) {
  return Newslist()
    ..resultList = (json['resultList'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..pageNum = json['pageNum'] as num
    ..pageSize = json['pageSize'] as num
    ..totalNum = json['totalNum'] as num;
}

Map<String, dynamic> _$NewslistToJson(Newslist instance) => <String, dynamic>{
      'resultList': instance.resultList,
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'totalNum': instance.totalNum
    };
