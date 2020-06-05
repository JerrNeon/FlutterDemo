import 'package:child_star/models/models_index.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  static const DB_NAME = "child_star.db";
  static const VERSION = 2;

  Database _db;

  Future<String> getPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, DB_NAME);
  }

  Future open() async {
    if (_db == null) {
      String path = await getPath();
      _db = await openDatabase(
        path,
        version: VERSION,
        onCreate: (db, version) async {
          var batch = db.batch();
          _createTableMediaCacheV1(batch);
          _createTableXmlyResourceV2(batch);
          await batch.commit();
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          var batch = db.batch();
          if (oldVersion == 1) {
            _createTableXmlyResourceV2(batch);
          }
          await batch.commit();
        },
      );
    }
  }

  _createTableMediaCacheV1(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $tableMediaCache');
    batch.execute('''
            create table $tableMediaCache (
              $columnId integer primary key autoincrement,
              $columnType integer,
              $columnMediaId integer,
              $columnMediaType integer,
              $columnImageUrl text,
              $columnTitle text,
              $columnDesc text,
              $columnUrl text,
              $columnPath text
            )
          ''');
  }

  _createTableXmlyResourceV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $tableXmlyResource');
    batch.execute('''
            create table $tableXmlyResource (
              $columnXmlyId integer primary key autoincrement,
              $columnAlbumId integer,
              $columnTrackId integer,
              $columnTrackCoverUrl text,
              $columnTrackOrderNum integer,
              $columnCreatedAt integer,
              $columnUpdateAt integer
            )
          ''');
  }

  Future<int> insert(MediaCache mediaCache) async {
    return await _db?.insert(tableMediaCache, mediaCache.toMap());
  }

  Future<List<MediaCache>> getMediaCacheList(List<int> typeList) async {
    List<Map<String, dynamic>> list;
    if (typeList != null && typeList.isNotEmpty) {
      String where = "";
      typeList.asMap().keys.forEach((index) {
        where += '$columnType = ?';
        if (index != typeList.length - 1) {
          where += ' or ';
        }
      });
      list = await _db?.query(
        tableMediaCache,
        where: where,
        whereArgs: typeList,
      );
    } else {
      list = await _db?.query(tableMediaCache);
    }
    if (list != null && list.isNotEmpty) {
      return list.map((e) => MediaCache.fromMap(e)).toList();
    }
    return null;
  }

  Future<bool> isMediaCacheInsert(int mediaId) async {
    List<Map<String, dynamic>> list = await _db?.query(
      tableMediaCache,
      where: '$columnMediaId = ?',
      whereArgs: [mediaId],
    );
    return list != null && list.isNotEmpty;
  }

  Future<MediaCache> getMediaCache(int mediaId) async {
    List<Map<String, dynamic>> list = await _db?.query(
      tableMediaCache,
      where: '$columnMediaId = ?',
      whereArgs: [mediaId],
    );
    if (list != null && list.isNotEmpty) {
      return MediaCache.fromMap(list.first);
    }
    return null;
  }

  Future<int> update(MediaCache mediaCache) async {
    return _db?.update(
      tableMediaCache,
      mediaCache.toMap(),
      where: '$columnId = ?',
      whereArgs: [mediaCache.id],
    );
  }

  Future<int> delete(int id) async {
    return _db?.delete(
      tableMediaCache,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<XmlyResource>> getXmlyResourceList() async {
    List<Map<String, dynamic>> list =
        await _db?.query(tableXmlyResource, orderBy: "$columnUpdateAt desc");
    return list.map((e) => XmlyResource.fromMap(e)).toList();
  }

  Future<bool> isXmlyResourceInsert(int albumId) async {
    List<Map<String, dynamic>> list = await _db?.query(
      tableXmlyResource,
      where: '$columnAlbumId = ?',
      whereArgs: [albumId],
    );
    return list != null && list.isNotEmpty;
  }

  Future<int> updateXmlyResource(XmlyResource xmlyResource) async {
    return _db?.update(
      tableXmlyResource,
      xmlyResource.toMap(),
      where: '$columnXmlyId = ?',
      whereArgs: [xmlyResource.id],
    );
  }

  Future<int> deleteXmlyResource(int id) async {
    return _db?.delete(
      tableXmlyResource,
      where: '$columnXmlyId = ?',
      whereArgs: [id],
    );
  }

  Future close() async => _db?.close();
}
