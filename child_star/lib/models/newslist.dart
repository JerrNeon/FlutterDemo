import 'package:json_annotation/json_annotation.dart';
import "news.dart";
part 'newslist.g.dart';

@JsonSerializable()
class Newslist {
    Newslist();

    List<News> resultList;
    num pageNum;
    num pageSize;
    num totalNum;
    
    factory Newslist.fromJson(Map<String,dynamic> json) => _$NewslistFromJson(json);
    Map<String, dynamic> toJson() => _$NewslistToJson(this);
}
