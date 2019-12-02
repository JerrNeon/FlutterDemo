import 'package:json_annotation/json_annotation.dart';

part 'banners.g.dart';

@JsonSerializable()
class Banners {
    Banners();

    String kvUrl;
    String params;
    String elementType;
    String shareTitle;
    String shareDesc;
    
    factory Banners.fromJson(Map<String,dynamic> json) => _$BannersFromJson(json);
    Map<String, dynamic> toJson() => _$BannersToJson(this);
}
