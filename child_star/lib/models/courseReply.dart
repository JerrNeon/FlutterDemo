import 'package:json_annotation/json_annotation.dart';

part 'courseReply.g.dart';

@JsonSerializable()
class CourseReply {
    CourseReply();

    num cId;
    String cTitle;
    String content;
    String createdAt;
    String headUrl;
    num id;
    String nickName;
    num parentId;
    num partNo;
    num replyId;
    String replyName;
    num sId;
    String sNo;
    String sTitle;
    num uid;
    
    factory CourseReply.fromJson(Map<String,dynamic> json) => _$CourseReplyFromJson(json);
    Map<String, dynamic> toJson() => _$CourseReplyToJson(this);
}
