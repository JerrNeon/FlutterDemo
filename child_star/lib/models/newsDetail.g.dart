// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetail _$NewsDetailFromJson(Map<String, dynamic> json) {
  return NewsDetail()
    ..authorId = json['authorId'] as num
    ..content = json['content'] as String
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
    ..authorName = json['authorName'] as String
    ..authorHeadUrl = json['authorHeadUrl'] as String
    ..authorIntroduction = json['authorIntroduction'] as String
    ..authorTag = json['authorTag'] as String
    ..like = json['like'] as num
    ..share = json['share'] as num
    ..isCollect = json['isCollect'] as bool
    ..isLike = json['isLike'] as bool
    ..collect = json['collect'] as num
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..isConcern = json['isConcern'] as bool
    ..comment = json['comment'] as num;
}

Map<String, dynamic> _$NewsDetailToJson(NewsDetail instance) =>
    <String, dynamic>{
      'authorId': instance.authorId,
      'content': instance.content,
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
      'authorName': instance.authorName,
      'authorHeadUrl': instance.authorHeadUrl,
      'authorIntroduction': instance.authorIntroduction,
      'authorTag': instance.authorTag,
      'like': instance.like,
      'share': instance.share,
      'isCollect': instance.isCollect,
      'isLike': instance.isLike,
      'collect': instance.collect,
      'tags': instance.tags,
      'isConcern': instance.isConcern,
      'comment': instance.comment
    };
