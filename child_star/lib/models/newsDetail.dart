import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
part 'newsDetail.g.dart';

@JsonSerializable()
class NewsDetail {
    NewsDetail();

    num authorId;
    String content;
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
    String authorName;
    String authorHeadUrl;
    String authorIntroduction;
    String authorTag;
    num like;
    num share;
    bool isCollect;
    bool isLike;
    num collect;
    List<Tag> tags;
    bool isConcern;
    num comment;
    
    factory NewsDetail.fromJson(Map<String,dynamic> json) => _$NewsDetailFromJson(json);
    Map<String, dynamic> toJson() => _$NewsDetailToJson(this);
}
