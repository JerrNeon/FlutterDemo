import 'package:json_annotation/json_annotation.dart';
import "columns.dart";
part 'columnsPageList.g.dart';

@JsonSerializable()
class ColumnsPageList {
    ColumnsPageList();

    @JsonKey(name : 'total_page') int totalPage;
    @JsonKey(name : 'total_count') int totalCount;
    @JsonKey(name : 'current_page') int currentPage;
    List<Columns> columns;
    
    factory ColumnsPageList.fromJson(Map<String,dynamic> json) => _$ColumnsPageListFromJson(json);
    Map<String, dynamic> toJson() => _$ColumnsPageListToJson(this);
}
