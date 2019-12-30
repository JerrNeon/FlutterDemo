import 'package:json_annotation/json_annotation.dart';

part 'myAttention.g.dart';

@JsonSerializable()
class MyAttention {
    MyAttention();

    String authorHeadUrl;
    num authorId;
    String authorIntroduction;
    String authorName;
    String authorSign;
    String createdAt;
    num uid;
    
    factory MyAttention.fromJson(Map<String,dynamic> json) => _$MyAttentionFromJson(json);
    Map<String, dynamic> toJson() => _$MyAttentionToJson(this);
}
