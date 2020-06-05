// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myCollectionPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCollectionPageList _$MyCollectionPageListFromJson(Map<String, dynamic> json) {
  return MyCollectionPageList()
    ..pageNum = json['pageNum'] as num
    ..pageSize = json['pageSize'] as num
    ..totalNum = json['totalNum'] as num
    ..ids = json['ids'] as String
    ..resultList = (json['resultList'] as List)
        ?.map((e) =>
            e == null ? null : MyCollection.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MyCollectionPageListToJson(
        MyCollectionPageList instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'totalNum': instance.totalNum,
      'ids': instance.ids,
      'resultList': instance.resultList
    };
