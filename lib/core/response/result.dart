import 'package:task_management/core/error/custom_error.dart';

sealed class Result<T> {
  const Result();

  R fold<R>(R Function(T) success, R Function(CustomError) failure);
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R fold<R>(R Function(T p1) success, R Function(CustomError p1) failure) =>
      success.call(data);
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final CustomError error;

  @override
  R fold<R>(R Function(T p1) success, R Function(CustomError p1) failure) =>
      failure.call(error);
}
