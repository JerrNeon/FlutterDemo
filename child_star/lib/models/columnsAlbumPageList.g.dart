// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'columnsAlbumPageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColumnsAlbumPageList _$ColumnsAlbumPageListFromJson(Map<String, dynamic> json) {
  return ColumnsAlbumPageList()
    ..totalPage = json['total_page'] as int
    ..totalCount = json['total_count'] as int
    ..currentPage = json['current_page'] as int
    ..contentType = json['content_type'] as int
    ..values = (json['values'] as List)
        ?.map(
            (e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ColumnsAlbumPageListToJson(
        ColumnsAlbumPageList instance) =>
    <String, dynamic>{
      'total_page': instance.totalPage,
      'total_count': instance.totalCount,
      'current_page': instance.currentPage,
      'content_type': instance.contentType,
      'values': instance.values
    };
