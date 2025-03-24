import 'package:task_management/core/error/custom_error.dart';
import 'package:task_management/core/response/result.dart';
import 'package:task_management/core/response/typedef.dart';
import 'package:task_management/features/task/data/data_source/local_data_source.dart';
import 'package:task_management/features/task/data/data_source/remote_data_source.dart';
import 'package:task_management/features/task/data/models/task_model.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  const TaskRepositoryImpl(
    LocalDatasource localDatasource,
    RemoteDatasource remoteDatasource,
  ) : _remoteDatasource = remoteDatasource,
      _localDatasource = localDatasource;

  final LocalDatasource _localDatasource;
  final RemoteDatasource _remoteDatasource;

  @override
  FutureResult<Task> addTask({
    required String name,
    required String details,
    required bool isFavourite,
  }) {
    throw UnimplementedError();
  }

  @override
  FutureResult<Task> updateTask(Task task) {
    throw UnimplementedError();
  }

  @override
  FutureResult<List<Task>> get allDbTask async {
    try {
      var result = await _localDatasource.allTask;
      var list = List<Task>.generate(
        result.length,
        (i) => TaskModel.json(result[i]),
      );
      return Success(list);
    } catch (e) {
      if (e is CustomError) return Failure(e);
      return Failure(UnknownError());
    }
  }

  @override
  FutureResult<List<Task>> get fetchTask async {
    try {
      var result = await _remoteDatasource.fetchTask;
      var list = List<Task>.generate(
        result.length,
        (i) => TaskModel.json(result[i]),
      );
      return Success(list);
    } catch (e) {
      if (e is CustomError) return Failure(e);
      return Failure(UnknownError());
    }
  }

  @override
  FutureResult<bool> insert(Task task) async {
    try {
      var taskModel = TaskModel.entity(task);
      var result = await _localDatasource.insert(taskModel.toJson);
      return Success(result);
    } catch (e) {
      if (e is CustomError) return Failure(e);
      return Failure(UnknownError());
    }
  }
}
