part of 'add_or_update_task_cubit.dart';

sealed class AddOrUpdateTaskState {
  const AddOrUpdateTaskState();
}

final class AddOrUpdateTaskInitial extends AddOrUpdateTaskState {
  const AddOrUpdateTaskInitial();
}

final class AddOrUpdateTaskLoading extends AddOrUpdateTaskState {
  const AddOrUpdateTaskLoading();
}

final class AddOrUpdateTaskSuccess extends AddOrUpdateTaskState {
  const AddOrUpdateTaskSuccess(this.task);
  final Task task;
}

final class AddOrUpdateTaskError extends AddOrUpdateTaskState {
  const AddOrUpdateTaskError(this.message);

  final String message;
}
