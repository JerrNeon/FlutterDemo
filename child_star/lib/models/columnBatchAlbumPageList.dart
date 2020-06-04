import 'package:json_annotation/json_annotation.dart';
import 'index.dart';

@JsonSerializable()
class ColumnBatchAlbumPageList extends ColumnsPageList {
  ColumnBatchAlbumPageList({this.columns, this.albumFutures});

  List<Columns> columns;
  List<Future<ColumnsAlbumPageList>> albumFutures;
}
