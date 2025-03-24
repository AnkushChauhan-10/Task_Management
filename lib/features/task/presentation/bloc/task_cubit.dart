import 'package:bloc/bloc.dart';
import 'package:task_management/features/task/domain/usecase/fetch_tasks.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(FetchTaskUseCase fetchTaskUseCase)
    : _fetchTaskUseCase = fetchTaskUseCase,
      super(TaskInitial());

  final FetchTaskUseCase _fetchTaskUseCase;
}
