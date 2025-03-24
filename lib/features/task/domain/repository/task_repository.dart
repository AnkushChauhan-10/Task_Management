import 'package:get_it/get_it.dart';
import 'package:task_management/core/response/typedef.dart';
import 'package:task_management/features/task/data/data_source/local_data_source.dart';
import 'package:task_management/features/task/data/data_source/remote_data_source.dart';
import 'package:task_management/features/task/data/repository/task_repository.dart';
import 'package:task_management/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  const TaskRepository();

  FutureResult<List<Task>> get allDbTask;

  FutureResult<List<Task>> get fetchTask;

  FutureResult<bool> insert(Task task);

  FutureResult<Task> addTask({
    required String name,
    required String details,
    required bool isFavourite,
  });

  FutureResult<Task> updateTask(Task task);

  static void inject(GetIt di) => di.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(di<LocalDatasource>(), di<RemoteDatasource>()),
  );
}
