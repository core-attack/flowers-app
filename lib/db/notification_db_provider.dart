import 'package:flowers_app/db/db_provider.dart';
import 'package:flowers_app/models/flower.dart';
import 'package:flowers_app/models/notification_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotificationItemProvider with ChangeNotifier {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath!, DbProvider.dbName);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table ${NotificationItem.tableName} ( 
  ${NotificationItem.columnId} integer primary key autoincrement, 
  ${NotificationItem.columnMessage} text not null,
  ${NotificationItem.columnDayOfWeek} integer not null,
  ${NotificationItem.columnRepeatInWeeks} integer not null,
  ${NotificationItem.columnFlowerId} integer not null
  )
''');
        });
  }

  Future<NotificationItem> insert(NotificationItem entity) async {
    return await db.transaction((txn) async {
      entity.id = await txn.insert(
        NotificationItem.tableName,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
      return entity;
    });
  }

  Future<NotificationItem?> get(int id) async {
    List<Map> maps = await db.query(NotificationItem.tableName,
        columns: [
          NotificationItem.columnId,
          NotificationItem.columnMessage,
          NotificationItem.columnDayOfWeek,
          NotificationItem.columnRepeatInWeeks,
          NotificationItem.columnFlowerId
        ],
        where: '${NotificationItem.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return NotificationItem.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.transaction((txn) async {
      return await txn.delete(NotificationItem.tableName, where: '${NotificationItem.columnId} = ?', whereArgs: [id]);
    });
  }

  Future<int> update(NotificationItem entity) async {
    return await db.transaction((txn) async {
      return await txn.update(NotificationItem.tableName, entity.toMap(),
          where: '${NotificationItem.columnId} = ?', whereArgs: [entity.id]);
    });
  }

  Future close() async => db.close();
}