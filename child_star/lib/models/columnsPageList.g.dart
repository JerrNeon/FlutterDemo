// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'columnsPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColumnsPageList _$ColumnsPageListFromJson(Map<String, dynamic> json) {
  return ColumnsPageList()
    ..totalPage = json['total_page'] as int
    ..totalCount = json['total_count'] as int
    ..currentPage = json['current_page'] as int
    ..columns = (json['columns'] as List)
        ?.map((e) =>
            e == null ? null : Columns.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ColumnsPageListToJson(ColumnsPageList instance) =>
    <String, dynamic>{
      'total_page': instance.totalPage,
      'total_count': instance.totalCount,
      'current_page': instance.currentPage,
      'columns': instance.columns
    };
