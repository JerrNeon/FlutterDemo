// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myAttention.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAttention _$MyAttentionFromJson(Map<String, dynamic> json) {
  return MyAttention()
    ..authorHeadUrl = json['authorHeadUrl'] as String
    ..authorId = json['authorId'] as num
    ..authorIntroduction = json['authorIntroduction'] as String
    ..authorName = json['authorName'] as String
    ..authorSign = json['authorSign'] as String
    ..createdAt = json['createdAt'] as String
    ..uid = json['uid'] as num;
}

Map<String, dynamic> _$MyAttentionToJson(MyAttention instance) =>
    <String, dynamic>{
      'authorHeadUrl': instance.authorHeadUrl,
      'authorId': instance.authorId,
      'authorIntroduction': instance.authorIntroduction,
      'authorName': instance.authorName,
      'authorSign': instance.authorSign,
      'createdAt': instance.createdAt,
      'uid': instance.uid
    };
