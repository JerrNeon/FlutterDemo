import 'package:json_annotation/json_annotation.dart';

part 'lecture.g.dart';

@JsonSerializable()
class Lecture {
    Lecture();

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
    bool isNew;
    
    factory Lecture.fromJson(Map<String,dynamic> json) => _$LectureFromJson(json);
    Map<String, dynamic> toJson() => _$LectureToJson(this);
}
