import 'package:json_annotation/json_annotation.dart';

part 'columns.g.dart';

@JsonSerializable()
class Columns {
  Columns({this.id});

  num id;
  @JsonKey(name: 'created_at')
  num createdAt;
  @JsonKey(name: 'updated_at')
  num updatedAt;
  String title;
  @JsonKey(name: 'cover_url_small')
  String coverUrlSmall;
  @JsonKey(name: 'cover_url_middle')
  String coverUrlMiddle;
  @JsonKey(name: 'cover_url_large')
  String coverUrlLarge;
  @JsonKey(name: 'content_type')
  int contentType;
  @JsonKey(name: 'content_num')
  int contentNum;
  String kind;

  factory Columns.fromJson(Map<String, dynamic> json) =>
      _$ColumnsFromJson(json);
  Map<String, dynamic> toJson() => _$ColumnsToJson(this);
}
