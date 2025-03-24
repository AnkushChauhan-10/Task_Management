import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/core/database/app_db.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/features/task/data/data_source/local_data_source.dart';
import 'package:task_management/features/task/data/data_source/remote_data_source.dart';
import 'package:task_management/features/task/domain/repository/task_repository.dart';
import 'package:task_management/features/task/domain/usecase/add_task.dart';
import 'package:task_management/features/task/domain/usecase/fetch_tasks.dart';
import 'package:task_management/features/task/domain/usecase/update_task.dart';

class DependencyInjector {
  static final _di = GetIt.instance;

  T call<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
    Type? type,
  }) => _di<T>(
    instanceName: instanceName,
    param1: param1,
    param2: param2,
    type: type,
  );

  Future<void> init() async {
    var appDb = await AppDatabase.initDatabase();
    _di.registerSingleton(appDb);
    _di.registerSingleton(http.Client());
    _di.registerSingleton(Connectivity());

    _injectLocalDataSource();
    _injectRemoteDataSource();
    _injectRepository();
    _injectUesCase();
  }

  void _injectLocalDataSource() {
    LocalDatasource.inject(_di);
  }

  void _injectRemoteDataSource() {
    RemoteDatasource.inject(_di);
  }

  void _injectRepository() {
    TaskRepository.inject(_di);
  }

  void _injectUesCase() {
    FetchTaskUseCase.inject(_di);
    UpdateTaskUseCase.inject(_di);
    AddTaskUseCase.inject(_di);
  }
}
