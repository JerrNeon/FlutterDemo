final String tableMediaCache = "media_cache";
final String columnId = "_id";
final String columnType = "type";
final String columnMediaId = "media_id";
final String columnMediaType = "media_type";
final String columnImageUrl = "image_url";
final String columnTitle = "title";
final String columnDesc = "desc";
final String columnUrl = "url";
final String columnPath = "path";

const TYPE_NEWS = 1; //资讯
const TYPE_LECTURE = 2; //讲堂
const TYPE_EXERCISE = 3; //活动

class MediaCache {
  int id; //自增id
  int type; //类型 1：资讯 2：讲堂 3：活动
  int mediaId; //媒体id
  int mediaType; //媒体类型 1：视频 2：音频 3:电子书
  String imageUrl; //图片
  String title; //标题
  String desc; //简介
  String url; //下载地址
  String path; //本地路径

  MediaCache();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnId: id,
      columnType: type,
      columnMediaId: mediaId,
      columnMediaType: mediaType,
      columnImageUrl: imageUrl,
      columnTitle: title,
      columnDesc: desc,
      columnUrl: url,
      columnPath: path,
    };
  }

  MediaCache.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    type = map[columnType];
    mediaId = map[columnMediaId];
    mediaType = map[columnMediaType];
    imageUrl = map[columnImageUrl];
    title = map[columnTitle];
    desc = map[columnDesc];
    url = map[columnUrl];
    path = map[columnPath];
  }
}
