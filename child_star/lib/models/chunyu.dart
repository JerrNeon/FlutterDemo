import 'package:json_annotation/json_annotation.dart';

part 'chunyu.g.dart';

@JsonSerializable()
class Chunyu {
    Chunyu();

    String linkUrl;
    
    factory Chunyu.fromJson(Map<String,dynamic> json) => _$ChunyuFromJson(json);
    Map<String, dynamic> toJson() => _$ChunyuToJson(this);
}
