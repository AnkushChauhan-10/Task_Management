import 'package:bloc/bloc.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/domain/usecase/add_task.dart';
import 'package:task_management/features/task/domain/usecase/update_task.dart';
import 'package:task_management/features/task/presentation/bloc/task_list/task_cubit.dart';

part 'add_or_update_task_state.dart';

class AddOrUpdateTaskCubit extends Cubit<AddOrUpdateTaskState> {
  AddOrUpdateTaskCubit({
    required this.cubit,
    required this.updateTaskUseCase,
    required this.addTaskUseCase,
  }) : super(AddOrUpdateTaskInitial());

  final TaskCubit cubit;
  final UpdateTaskUseCase updateTaskUseCase;
  final AddTaskUseCase addTaskUseCase;

  Future<void> changeIsFavourite(Task task) async {
    emit(AddOrUpdateTaskLoading());
    var result = await updateTaskUseCase(
      task.copyWith(isFavourite: !task.isFavourite),
    );
    var newSate = result.fold(
      (s) => AddOrUpdateTaskSuccess(s),
      (f) => AddOrUpdateTaskError(""),
    );
    emit(newSate);
    if (newSate is AddOrUpdateTaskSuccess) cubit.replaceTask(newSate.task);
  }

  Future<void> addTask({required String name, required String details}) async {
    emit(AddOrUpdateTaskLoading());
    var result = await addTaskUseCase(
      name: name,
      details: details,
      isFavourite: false,
    );
    var newSate = result.fold(
      (s) => AddOrUpdateTaskSuccess(s),
      (f) => AddOrUpdateTaskError(""),
    );
    emit(newSate);
    if (newSate is AddOrUpdateTaskSuccess) cubit.addTask(newSate.task);
  }

  Future<void> updateTask(
    Task task, {
    required String name,
    required String details,
  }) async {
    emit(AddOrUpdateTaskLoading());
    var result = await updateTaskUseCase(
      task.copyWith(name: name, details: details),
    );
    var newSate = result.fold(
      (s) => AddOrUpdateTaskSuccess(s),
      (f) => AddOrUpdateTaskError(""),
    );
    emit(newSate);
    if (newSate is AddOrUpdateTaskSuccess) cubit.replaceTask(newSate.task);
  }
}
