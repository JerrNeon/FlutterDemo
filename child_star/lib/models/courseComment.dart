import 'package:json_annotation/json_annotation.dart';
import "courseReply.dart";
part 'courseComment.g.dart';

@JsonSerializable()
class CourseComment {
    CourseComment();

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
    num sNo;
    String sTitle;
    num uid;
    List<CourseReply> replyList;
    
    factory CourseComment.fromJson(Map<String,dynamic> json) => _$CourseCommentFromJson(json);
    Map<String, dynamic> toJson() => _$CourseCommentToJson(this);
}
