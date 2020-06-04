import 'package:json_annotation/json_annotation.dart';

part 'xmlyBanners.g.dart';

@JsonSerializable()
class XmlyBanners {
    XmlyBanners();

    num id;
    @JsonKey(name : 'banner_title') String bannerTitle;
    @JsonKey(name : 'banner_cover_url') String bannerCoverUrl;
    @JsonKey(name : 'short_title') String shortTitle;
    @JsonKey(name : 'banner_content_type') int bannerContentType;
    @JsonKey(name : 'is_paid') int isPaid;
    @JsonKey(name : 'operation_category_id') int operationCategoryId;
    @JsonKey(name : 'banner_content_id') int bannerContentId;
    @JsonKey(name : 'banner_content_title') String bannerContentTitle;
    @JsonKey(name : 'redirect_url') String redirectUrl;
    @JsonKey(name : 'created_at') num createdAt;
    @JsonKey(name : 'updated_at') num updatedAt;
    String kind;
    
    factory XmlyBanners.fromJson(Map<String,dynamic> json) => _$XmlyBannersFromJson(json);
    Map<String, dynamic> toJson() => _$XmlyBannersToJson(this);
}
