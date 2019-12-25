import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
part 'tagListItem.g.dart';

@JsonSerializable()
class TagListItem {
    TagListItem();

    num id;
    String name;
    List<Tag> tags;
    
    factory TagListItem.fromJson(Map<String,dynamic> json) => _$TagListItemFromJson(json);
    Map<String, dynamic> toJson() => _$TagListItemToJson(this);
}
