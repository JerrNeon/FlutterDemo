// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exerciseTag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseTag _$ExerciseTagFromJson(Map<String, dynamic> json) {
  return ExerciseTag()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..icon = json['icon'] as String;
}

Map<String, dynamic> _$ExerciseTagToJson(ExerciseTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon
    };
