import 'package:json_annotation/json_annotation.dart';
import "tag.dart";
import "lecturePart.dart";
part 'lectureDetail.g.dart';

@JsonSerializable()
class LectureDetail {
    LectureDetail();

    String auditAt;
    String auditor;
    num authorId;
    String content;
    String createdAt;
    String descr;
    String headUrl;
    String headUrlList;
    num id;
    String instruction;
    String lecturerHeadUrl;
    String lecturerInstruction;
    String lecturerName;
    num price;
    num sales;
    num status;
    String title;
    String updatedAt;
    num weight;
    num like;
    num comment;
    List<Tag> tags;
    List<LecturePart> parts;
    num partNum;
    bool isLock;
    num lookNum;
    
    factory LectureDetail.fromJson(Map<String,dynamic> json) => _$LectureDetailFromJson(json);
    Map<String, dynamic> toJson() => _$LectureDetailToJson(this);
}
