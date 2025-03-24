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
    return result;
  }

  @override
  Future<bool> insert(DataMap value) async {
    var result = await _appDatabase.insert(
      TaskTable.tableName,
      value,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  @override
  Future<bool> updateTask(DataMap value) async {
    var result = await _appDatabase.update(
      TaskTable.tableName,
      value,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }
}
