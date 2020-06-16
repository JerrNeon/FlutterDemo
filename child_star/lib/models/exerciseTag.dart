import 'package:json_annotation/json_annotation.dart';

part 'exerciseTag.g.dart';

@JsonSerializable()
class ExerciseTag {
    ExerciseTag();

    num id;
    String name;
    String icon;
    
    factory ExerciseTag.fromJson(Map<String,dynamic> json) => _$ExerciseTagFromJson(json);
    Map<String, dynamic> toJson() => _$ExerciseTagToJson(this);
}
