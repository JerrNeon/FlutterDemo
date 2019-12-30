import 'package:json_annotation/json_annotation.dart';

part 'myCollection.g.dart';

@JsonSerializable()
class MyCollection {
    MyCollection();

    num cid;
    String createdAt;
    String headUrl;
    String introduction;
    String title;
    num type;
    num uid;
    
    factory MyCollection.fromJson(Map<String,dynamic> json) => _$MyCollectionFromJson(json);
    Map<String, dynamic> toJson() => _$MyCollectionToJson(this);
}
