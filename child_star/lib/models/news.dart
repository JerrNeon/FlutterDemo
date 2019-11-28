import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
    News();

    num authorId;
    String content;
    num contentPay;
    String headUrl;
    num id;
    String innerWord;
    num lookRecord;
    String mediaTime;
    String mediaUrl;
    String partContent;
    String picFour;
    String picOne;
    String picThree;
    String picTwo;
    String tag;
    String title;
    num type;
    num like;
    bool isLike;
    
    factory News.fromJson(Map<String,dynamic> json) => _$NewsFromJson(json);
    Map<String, dynamic> toJson() => _$NewsToJson(this);
}
