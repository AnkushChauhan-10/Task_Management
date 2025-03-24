import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/core/error/custom_error.dart';
import 'package:task_management/core/response/result.dart';
import 'package:task_management/core/response/typedef.dart';
import 'package:task_management/core/util/extensions/connectivity.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';

class AddTaskUseCase {
  const AddTaskUseCase(TaskRepository repository, Connectivity connectivity)
    : _repository = repository,
      _connectivity = connectivity;
  final TaskRepository _repository;
  final Connectivity _connectivity;

  FutureResult<Task> call({
    required String name,
    required String details,
    required bool isFavourite,
  }) async {
    if (!await _connectivity.isConnected) return Failure(NoInternet());
    var addTask = await _repository.addTask(
      name: name,
      details: details,
      isFavourite: isFavourite,
    );
    return addTask.fold((s) => Success(s), (f) => Failure(f));
  }

  static void inject(GetIt di) => di.registerLazySingleton<AddTaskUseCase>(
    () => AddTaskUseCase(di<TaskRepository>(), di<Connectivity>()),
  );
}
