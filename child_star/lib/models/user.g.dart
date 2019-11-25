// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as String
    ..nickName = json['nickName'] as String
    ..headUrl = json['headUrl'] as String
    ..role = json['role'] as num
    ..roleTime = json['roleTime'] as String
    ..tagId = json['tagId'] as num
    ..mobileNo = json['mobileNo'] as String
    ..country = json['country'] as String
    ..province = json['province'] as String
    ..city = json['city'] as String
    ..birthday = json['birthday'] as String
    ..sex = json['sex'] as num
    ..followCount = json['followCount'] as num
    ..tagName = json['tagName'] as String
    ..tagIcon = json['tagIcon'] as String
    ..mySign = json['mySign'] as String
    ..points = json['points'] as num
    ..score = json['score'] as num
    ..vipPrice = json['vipPrice'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'headUrl': instance.headUrl,
      'role': instance.role,
      'roleTime': instance.roleTime,
      'tagId': instance.tagId,
      'mobileNo': instance.mobileNo,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'birthday': instance.birthday,
      'sex': instance.sex,
      'followCount': instance.followCount,
      'tagName': instance.tagName,
      'tagIcon': instance.tagIcon,
      'mySign': instance.mySign,
      'points': instance.points,
      'score': instance.score,
      'vipPrice': instance.vipPrice
    };
