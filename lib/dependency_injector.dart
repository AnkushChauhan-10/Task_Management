import 'package:get_it/get_it.dart';
import 'package:task_management/core/database/app_db.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/features/task/data/data_source/local_data_source.dart';
import 'package:task_management/features/task/data/data_source/remote_data_source.dart';
import 'package:task_management/features/task/domain/usecase/fetch_tasks.dart';

class DependencyInjector {
  static final _di = GetIt.instance;

  Future<void> init() async {
    var appDb = await AppDatabase.initDatabase();
    _di.registerSingleton(appDb);
    _di.registerSingleton(http.Client());

    _injectLocalDataSource();
    _injectRemoteDataSource();
    _injectUesCase();
  }

  void _injectLocalDataSource() {
    LocalDatasource.inject(_di);
  }

  void _injectRemoteDataSource() {
    RemoteDatasource.inject(_di);
  }

  void _injectUesCase() {
    FetchTaskUseCase.inject(_di);
  }
}
