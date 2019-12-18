import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
    Exercise();

    String content;
    String createdAt;
    String descr;
    String downloadUrl;
    String eTime;
    num enabled;
    String headUrl;
    num id;
    String sTime;
    num tagId;
    String tagName;
    String title;
    num type;
    String updatedAt;
    num weight;
    String btnName;
    String tagWord;
    String tagWordColor;
    String jumpUrl;
    
    factory Exercise.fromJson(Map<String,dynamic> json) => _$ExerciseFromJson(json);
    Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
