import 'package:flowers_app/models/flower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'db_provider.dart';
//import 'package:toast/toast.dart';

class FlowerProvider with ChangeNotifier {
  FlowerProvider._();

  static final FlowerProvider dbProvider = FlowerProvider();

  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath!, DbProvider.dbName);
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table ${Flower.tableName} (
  ${Flower.columnId} integer primary key autoincrement,
  ${Flower.columnTitle} text not null,
  ${Flower.columnImagePath} text)
''');
    });
  }

  List<Flower> entities = [];
  Flower? entity;
  bool loading = false;

  Future<Flower?> get(context, int? id) async {
    print("trying to get $id");

    final db = await database;

    loading = true;
    entity = null;

    if (id != null) {
      List<Map> maps = await db.query(Flower.tableName,
          columns: [
            Flower.columnId,
            Flower.columnTitle,
            Flower.columnImagePath
          ],
          where: '${Flower.columnId} = ?',
          whereArgs: [id]);

      if (maps.length > 0) {
        entity = Flower.fromMap(maps.first);
      } else {
        entity = null;
      }
    }

    //else {
    //  Toast.show(
    //      "The records with id=$id is not exist",
    //      context,
    //      duration: 2,
    //      backgroundColor: Colors.redAccent);
    //}

    loading = false;
    notifyListeners();

    //db.close();
  }

  Future<List<Flower>?> getAll(context) async {
    print("trying to get all flowers...");

    final db = await database;

    loading = true;

    List<Map> maps = await db.query(Flower.tableName,
        columns: [Flower.columnId, Flower.columnTitle, Flower.columnImagePath]
    );

    if (maps.length > 0) {
      maps.forEach((row) => entities.add(Flower.fromMap(row)));
    } else {
      entities = [];
    }
    //else {
    //  Toast.show(
    //      "Data is empty",
    //      context,
    //      duration: 2,
    //      backgroundColor: Colors.redAccent);
    //}

    print("entities: ");
    entities.map((e) => print(e.title));

    loading = false;

    notifyListeners();

    //db.close();
  }

  void upsert(var context, Flower e) async {
    get(context, e.id);

    if (entity == null){
      await insert(e);
    } else {
      await update(e);
    }
  }

  Future<Flower> insert(Flower entity) async {
    final db = await database;

    return await db.transaction((txn) async {
      entity.id = await txn.insert(
        Flower.tableName,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return entity;
    });
  }

  Future<int> update(Flower entity) async {
    final db = await database;

    return await db.transaction((txn) async {
      return await txn.update(Flower.tableName, entity.toMap(),
          where: '${Flower.columnId} = ?', whereArgs: [entity.id]);
    });
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.transaction((txn) async {
      return await txn.delete(Flower.tableName, where: '${Flower.columnId} = ?', whereArgs: [id]);
    });
  }
}