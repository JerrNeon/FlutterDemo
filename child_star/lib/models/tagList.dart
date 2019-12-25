import 'package:json_annotation/json_annotation.dart';
import "tagListItem.dart";
part 'tagList.g.dart';

@JsonSerializable()
class TagList {
    TagList();

    num id;
    String name;
    List<TagListItem> tags;
    
    factory TagList.fromJson(Map<String,dynamic> json) => _$TagListFromJson(json);
    Map<String, dynamic> toJson() => _$TagListToJson(this);
}
