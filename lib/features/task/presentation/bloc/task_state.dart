part of 'task_cubit.dart';

sealed class TaskState {
  const TaskState();
}

final class TaskInitial extends TaskState {
  const TaskInitial();
}

final class TaskLoading extends TaskState {
  const TaskLoading();
}

final class TaskSuccess extends TaskState {
  const TaskSuccess();
}

final class TaskError extends TaskState {
  const TaskError();
}