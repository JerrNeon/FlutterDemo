import 'package:child_star/models/models_index.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  static const DB_NAME = "child_star.db";
  static const VERSION = 1;

  Database _db;

  Future<String> getPath() async {
    var databasesPath = await getDatabasesPath();
    return join(databasesPath, DB_NAME);
  }

  Future open() async {
    if (_db == null) {
      String path = await getPath();
      _db = await openDatabase(path, version: VERSION,
          onCreate: (db, version) async {
        await db.execute('''
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
      });
    }
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

  Future<bool> getMediaCache(int mediaId) async {
    List<Map<String, dynamic>> list = await _db?.query(
      tableMediaCache,
      where: '$columnMediaId = ?',
      whereArgs: [mediaId],
    );
    return list != null && list.isNotEmpty;
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

  Future close() async => _db?.close();
}
