// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News()
    ..authorId = json['authorId'] as num
    ..content = json['content'] as String
    ..contentPay = json['contentPay'] as num
    ..headUrl = json['headUrl'] as String
    ..id = json['id'] as num
    ..innerWord = json['innerWord'] as String
    ..lookRecord = json['lookRecord'] as num
    ..mediaTime = json['mediaTime'] as String
    ..mediaUrl = json['mediaUrl'] as String
    ..partContent = json['partContent'] as String
    ..picFour = json['picFour'] as String
    ..picOne = json['picOne'] as String
    ..picThree = json['picThree'] as String
    ..picTwo = json['picTwo'] as String
    ..tag = json['tag'] as String
    ..title = json['title'] as String
    ..type = json['type'] as num
    ..like = json['like'] as num
    ..isLike = json['isLike'] as bool;
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'content': instance.content,
      'contentPay': instance.contentPay,
      'headUrl': instance.headUrl,
      'id': instance.id,
      'innerWord': instance.innerWord,
      'lookRecord': instance.lookRecord,
      'mediaTime': instance.mediaTime,
      'mediaUrl': instance.mediaUrl,
      'partContent': instance.partContent,
      'picFour': instance.picFour,
      'picOne': instance.picOne,
      'picThree': instance.picThree,
      'picTwo': instance.picTwo,
      'tag': instance.tag,
      'title': instance.title,
      'type': instance.type,
      'like': instance.like,
      'isLike': instance.isLike
    };
