import 'package:json_annotation/json_annotation.dart';

part 'lecturePart.g.dart';

@JsonSerializable()
class LecturePart {
    LecturePart();

    String partHeadUrl;
    String partName;
    num partNo;
    num subjectNum;
    
    factory LecturePart.fromJson(Map<String,dynamic> json) => _$LecturePartFromJson(json);
    Map<String, dynamic> toJson() => _$LecturePartToJson(this);
}
