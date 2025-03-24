import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/core/database/task_table.dart';
import 'package:task_management/core/response/typedef.dart';

class AppDatabase {
  const AppDatabase(this._database);

  final Database _database;

  static Future<AppDatabase> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return TaskTable.create(db);
      },
    );

    return AppDatabase(db);
  }

  Future<List<DataMap>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async => _database.query(
    table,
    distinct: distinct,
    columns: columns,
    whereArgs: whereArgs,
    where: where,
    groupBy: groupBy,
    having: having,
    offset: offset,
    limit: limit,
    orderBy: orderBy,
  );

  Future<bool> insert(
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async =>
      await _database.insert(
                table,
                values,
                nullColumnHack: nullColumnHack,
                conflictAlgorithm: conflictAlgorithm,
              ) ==
              0
          ? false
          : true;

  Future<bool> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async =>
      await _database.update(
                table,
                values,
                where: where,
                whereArgs: whereArgs,
                conflictAlgorithm: conflictAlgorithm,
              ) ==
              0
          ? false
          : true;
}
