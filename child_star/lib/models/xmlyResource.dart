final String tableXmlyResource = "xmly_resource";
final String columnXmlyId = "_id";
final String columnAlbumId = "album_id";
final String columnTrackId = "track_id";
final String columnTrackCoverUrl = "track_cover_url";
final String columnTrackOrderNum = "track_order_num";
final String columnCreatedAt = "created_at";
final String columnUpdateAt = "update_at";

class XmlyResource {
  int id; //自增id
  int albumId; //专辑id
  int trackId; //声音id(当前专辑最近播放的声音)
  String trackCoverUrl; //声音封面图url
  int trackOrderNum; //声音在专辑中的排序值
  int createdAt; //	Long	专辑创建时间，Unix毫秒数时间戳
  int updateAt; //	Long	专辑更新时间，Unix毫秒数时间戳

  XmlyResource({
    this.albumId,
    this.trackId,
    this.trackCoverUrl,
    this.trackOrderNum,
    this.createdAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      columnXmlyId: id,
      columnAlbumId: albumId,
      columnTrackId: trackId,
      columnTrackCoverUrl: trackCoverUrl,
      columnTrackOrderNum: trackOrderNum,
      columnCreatedAt: createdAt,
      columnUpdateAt: updateAt,
    };
  }

  XmlyResource.fromMap(Map<String, dynamic> map) {
    id = map[columnXmlyId];
    albumId = map[columnAlbumId];
    trackId = map[columnTrackId];
    trackCoverUrl = map[columnTrackCoverUrl];
    trackOrderNum = map[columnTrackOrderNum];
    createdAt = map[columnCreatedAt];
    updateAt = map[columnUpdateAt];
  }
}
