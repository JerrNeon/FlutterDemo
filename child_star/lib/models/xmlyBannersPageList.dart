import 'package:json_annotation/json_annotation.dart';
import "xmlyBanners.dart";
part 'xmlyBannersPageList.g.dart';

@JsonSerializable()
class XmlyBannersPageList {
    XmlyBannersPageList();

    @JsonKey(name : 'total_page') int totalPage;
    @JsonKey(name : 'total_count') int totalCount;
    @JsonKey(name : 'current_page') int currentPage;
    List<XmlyBanners> banners;
    
    factory XmlyBannersPageList.fromJson(Map<String,dynamic> json) => _$XmlyBannersPageListFromJson(json);
    Map<String, dynamic> toJson() => _$XmlyBannersPageListToJson(this);
}
