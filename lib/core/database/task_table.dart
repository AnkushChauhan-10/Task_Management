import 'package:sqflite/sqflite.dart';

abstract class TaskTable {
  const TaskTable._();

  static Future<void> create(Database db) async => await db.execute(
    ''
    'CREATE TABLE $tableName($idColumn INTEGER KEY, '
    '$nameColumn TEXT, $taskDetailsColumn TEXT, '
    '$createdDateColumn TEXT, $updateDateColumn TEXT, '
    '$isFavouriteColumn INTEGER)'
    '',
  );

  static const String tableName = "task_id";
  static const String idColumn = "task_id";
  static const String nameColumn = "task_name";
  static const String createdDateColumn = "created_date";
  static const String updateDateColumn = "updated_date";
  static const String taskDetailsColumn = "task_details";
  static const String isFavouriteColumn = "is_favourite";
}
