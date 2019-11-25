import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String id;
    String nickName;
    String headUrl;
    num role;
    String roleTime;
    num tagId;
    String mobileNo;
    String country;
    String province;
    String city;
    String birthday;
    num sex;
    num followCount;
    String tagName;
    String tagIcon;
    String mySign;
    num points;
    num score;
    num vipPrice;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
