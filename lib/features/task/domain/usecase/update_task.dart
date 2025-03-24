import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/core/error/custom_error.dart';
import 'package:task_management/core/response/result.dart';
import 'package:task_management/core/response/typedef.dart';
import 'package:task_management/core/util/extensions/connectivity.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';

class UpdateTaskUseCase {
  const UpdateTaskUseCase(TaskRepository repository, Connectivity connectivity)
    : _repository = repository,
      _connectivity = connectivity;
  final TaskRepository _repository;
  final Connectivity _connectivity;

  FutureResult<Task> call(Task task) async {
    if (!await _connectivity.isConnected) return Failure(NoInternet());
    var updateTask = await _repository.updateTask(task);
    return updateTask.fold((s) => Success(s), (f) => Failure(f));
  }

  static void inject(GetIt di) => di.registerLazySingleton<UpdateTaskUseCase>(
    () => UpdateTaskUseCase(di<TaskRepository>(), di<Connectivity>()),
  );
}
