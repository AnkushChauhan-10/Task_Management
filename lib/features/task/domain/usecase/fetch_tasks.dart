import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/core/response/result.dart';
import 'package:task_management/core/response/typedef.dart';
import 'package:task_management/core/util/extensions/connectivity.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';

class FetchTaskUseCase {
  const FetchTaskUseCase(TaskRepository repository, Connectivity connectivity)
    : _repository = repository,
      _connectivity = connectivity;
  final TaskRepository _repository;
  final Connectivity _connectivity;

  FutureResult<List<Task>> call() async {
    if (!await _connectivity.isConnected) {
      var localTask = await _repository.allDbTask;
      return localTask;
    }
    var remoteTask = await _repository.fetchTask;
    return await remoteTask.fold(
      (s) async {
        for (var task in s) {
          await _repository.insert(task);
        }
        return Success(s);
      },
      (f) async {
        var localTask = await _repository.allDbTask;
        return localTask;
      },
    );
  }

  static void inject(GetIt di) => di.registerLazySingleton<FetchTaskUseCase>(
    () => FetchTaskUseCase(di<TaskRepository>(), di<Connectivity>()),
  );
}
