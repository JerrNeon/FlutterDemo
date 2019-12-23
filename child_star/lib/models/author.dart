import 'package:json_annotation/json_annotation.dart';
import "news.dart";
part 'author.g.dart';

@JsonSerializable()
class Author {
    Author();

    num articles;
    String backgroundUrl;
    String createTime;
    num fans;
    String headUrl;
    num id;
    String introduction;
    String name;
    String tag;
    String updateTime;
    bool isConcern;
    List<News> infoList;
    
    factory Author.fromJson(Map<String,dynamic> json) => _$AuthorFromJson(json);
    Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
