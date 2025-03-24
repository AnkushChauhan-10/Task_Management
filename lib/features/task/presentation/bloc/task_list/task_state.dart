part of 'task_cubit.dart';

sealed class TaskState {
  const TaskState(this.tasks);

  final List<Task> tasks;
}

final class TaskInitial extends TaskState {
  const TaskInitial(super.tasks);
}

final class TaskLoading extends TaskState {
  const TaskLoading(super.tasks);
}

final class TaskSuccess extends TaskState {
  const TaskSuccess(super.tasks);
}

final class TaskError extends TaskState {
  const TaskError(this.message, super.tasks);

  final String message;
}
