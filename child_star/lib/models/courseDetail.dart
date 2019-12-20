import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
part 'courseDetail.g.dart';

@JsonSerializable()
class CourseDetail {
    CourseDetail();

    num authorId;
    num cId;
    String courseTitle;
    String courseDescr;
    String createdAt;
    String headUrl;
    num id;
    String instruction;
    num isDelete;
    String mediaTime;
    String mediaUrl;
    String partHeadUrl;
    String partName;
    num partNo;
    num sNo;
    String title;
    num type;
    String updatedAt;
    num like;
    num collect;
    num comment;
    bool isCollect;
    bool isLike;
    num watch;
    List<Tag> tags;
    
    factory CourseDetail.fromJson(Map<String,dynamic> json) => _$CourseDetailFromJson(json);
    Map<String, dynamic> toJson() => _$CourseDetailToJson(this);
}
