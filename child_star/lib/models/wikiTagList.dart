import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
part 'wikiTagList.g.dart';

@JsonSerializable()
class WikiTagList {
    WikiTagList();

    num id;
    String name;
    List<Tag> tags;
    
    factory WikiTagList.fromJson(Map<String,dynamic> json) => _$WikiTagListFromJson(json);
    Map<String, dynamic> toJson() => _$WikiTagListToJson(this);
}
