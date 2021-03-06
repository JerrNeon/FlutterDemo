import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
    Album();

    num id;
    String kind;
    @JsonKey(name : 'category_id') int categoryId;
    @JsonKey(name : 'album_title') String albumTitle;
    @JsonKey(name : 'album_tags') String albumTags;
    @JsonKey(name : 'album_intro') String albumIntro;
    @JsonKey(name : 'cover_url_small') String coverUrlSmall;
    @JsonKey(name : 'cover_url_middle') String coverUrlMiddle;
    @JsonKey(name : 'cover_url_large') String coverUrlLarge;
    @JsonKey(name : 'tracks_natural_ordered') bool tracksNaturalOrdered;
    @JsonKey(name : 'play_count') int playCount;
    @JsonKey(name : 'favorite_count') int favoriteCount;
    @JsonKey(name : 'share_count') int shareCount;
    @JsonKey(name : 'subscribe_count') int subscribeCount;
    @JsonKey(name : 'include_track_count') int includeTrackCount;
    @JsonKey(name : 'is_finished') int isFinished;
    @JsonKey(name : 'short_intro') String shortIntro;
    @JsonKey(name : 'short_rich_intro') String shortRichIntro;
    
    factory Album.fromJson(Map<String,dynamic> json) => _$AlbumFromJson(json);
    Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
