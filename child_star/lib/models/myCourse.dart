import 'package:json_annotation/json_annotation.dart';

part 'myCourse.g.dart';

@JsonSerializable()
class MyCourse {
    MyCourse();

    num authorId;
    String descr;
    String headUrl;
    String headUrlList;
    num id;
    num price;
    String title;
    
    factory MyCourse.fromJson(Map<String,dynamic> json) => _$MyCourseFromJson(json);
    Map<String, dynamic> toJson() => _$MyCourseToJson(this);
}
