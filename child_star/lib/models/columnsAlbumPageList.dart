import 'package:json_annotation/json_annotation.dart';
import "album.dart";
part 'columnsAlbumPageList.g.dart';

@JsonSerializable()
class ColumnsAlbumPageList {
    ColumnsAlbumPageList();

    @JsonKey(name : 'total_page') int totalPage;
    @JsonKey(name : 'total_count') int totalCount;
    @JsonKey(name : 'current_page') int currentPage;
    @JsonKey(name : 'content_type') int contentType;
    List<Album> values;
    
    factory ColumnsAlbumPageList.fromJson(Map<String,dynamic> json) => _$ColumnsAlbumPageListFromJson(json);
    Map<String, dynamic> toJson() => _$ColumnsAlbumPageListToJson(this);
}
