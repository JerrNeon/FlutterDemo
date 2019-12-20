import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
    Course();

    num authorId;
    num cId;
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
    bool isLock;
    num watch;
    
    factory Course.fromJson(Map<String,dynamic> json) => _$CourseFromJson(json);
    Map<String, dynamic> toJson() => _$CourseToJson(this);
}
