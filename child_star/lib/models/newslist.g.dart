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
        ?.toList();
}

Map<String, dynamic> _$NewslistToJson(Newslist instance) =>
    <String, dynamic>{'resultList': instance.resultList};
