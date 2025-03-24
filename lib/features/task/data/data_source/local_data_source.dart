import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/core/database/app_db.dart';
import 'package:task_management/core/database/task_table.dart';
import 'package:task_management/core/response/typedef.dart';

abstract interface class LocalDatasource {
  const LocalDatasource();

  Future<bool> insert(DataMap value);

  Future<List<DataMap>> get allTask;

  Future<bool> updateTask(DataMap value);

  static void inject(GetIt di) => di.registerLazySingleton<LocalDatasource>(
    () => LocalDatasourceImpl(di<AppDatabase>()),
  );
}

class LocalDatasourceImpl extends LocalDatasource {
  const LocalDatasourceImpl(AppDatabase appDatabase)
    : _appDatabase = appDatabase;
  final AppDatabase _appDatabase;

  @override
  Future<List<DataMap>> get allTask async {
    var result = await _appDatabase.query(TaskTable.tableName);
    var list = List.generate(
      result.length,
      (i) => {
        TaskTable.idColumn: result[i][TaskTable.idColumn],
        TaskTable.nameColumn: result[i][TaskTable.nameColumn],
        TaskTable.taskDetailsColumn: result[i][TaskTable.taskDetailsColumn],
        TaskTable.createdDateColumn: result[i][TaskTable.createdDateColumn],
        TaskTable.updateDateColumn: result[i][TaskTable.updateDateColumn],
        TaskTable.isFavouriteColumn:
            result[i][TaskTable.isFavouriteColumn] == 0 ? false : true,
      },
    );
    return list;
  }

  @override
  Future<bool> insert(DataMap value) async {
    DataMap val = {
      TaskTable.idColumn: value[TaskTable.idColumn],
      TaskTable.nameColumn: value[TaskTable.nameColumn],
      TaskTable.taskDetailsColumn: value[TaskTable.taskDetailsColumn],
      TaskTable.createdDateColumn: value[TaskTable.createdDateColumn],
      TaskTable.updateDateColumn: value[TaskTable.updateDateColumn],
      TaskTable.isFavouriteColumn: value[TaskTable.isFavouriteColumn] ? 1 : 0,
    };
    var result = await _appDatabase.insert(
      TaskTable.tableName,
      val,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return result;
  }

  @override
  Future<bool> updateTask(DataMap value) async {
    DataMap val = {
      TaskTable.nameColumn: value[TaskTable.nameColumn],
      TaskTable.taskDetailsColumn: value[TaskTable.taskDetailsColumn],
      TaskTable.createdDateColumn: value[TaskTable.createdDateColumn],
      TaskTable.updateDateColumn: value[TaskTable.updateDateColumn],
      TaskTable.isFavouriteColumn: value[TaskTable.isFavouriteColumn] ? 1 : 0,
    };
    var result = await _appDatabase.update(
      TaskTable.tableName,
      where: "${TaskTable.idColumn} =?",
      whereArgs: [value[TaskTable.idColumn]],
      val,
    );
    return result;
  }
}
