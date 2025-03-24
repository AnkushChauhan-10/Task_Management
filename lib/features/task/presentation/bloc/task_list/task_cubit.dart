import 'package:bloc/bloc.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/domain/usecase/fetch_tasks.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(FetchTaskUseCase fetchTaskUseCase)
    : _fetchTaskUseCase = fetchTaskUseCase,
      super(TaskInitial([]));

  final FetchTaskUseCase _fetchTaskUseCase;

  Future<void> fetchTask() async {
    emit(TaskLoading(state.tasks));
    var result = await _fetchTaskUseCase();
    var newState = result.fold(
      (s) => TaskSuccess(s),
      (f) => TaskError(f.toString(), state.tasks),
    );
    emit(newState);
  }

  Future<void> refresh() async {
    var result = await _fetchTaskUseCase();
    var newState = result.fold(
          (s) => TaskSuccess(s),
          (f) => TaskError(f.toString(), state.tasks),
    );
    emit(newState);
  }

  void replaceTask(Task task) {
    var temp = <Task>[];
    for (var p1 in state.tasks) {
      temp.add(task.id == p1.id ? task : p1);
    }
    emit(TaskSuccess(temp));
  }

  void addTask(Task task) {
    var temp = <Task>[];
    temp.addAll(state.tasks);
    temp.add(task);
    emit(TaskSuccess(temp));
  }
}
