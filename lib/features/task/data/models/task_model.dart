import 'package:task_management/core/response/typedef.dart';
import 'package:task_management/features/task/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.name,
    required super.createdDate,
    required super.updateDate,
    required super.taskDetails,
    required super.isFavourite,
  });

  factory TaskModel.entity(Task val) => TaskModel(
    id: val.id,
    name: val.name,
    createdDate: val.createdDate,
    updateDate: val.updateDate,
    taskDetails: val.taskDetails,
    isFavourite: val.isFavourite,
  );

  factory TaskModel.json(DataMap val) => TaskModel(
    id: val["task_id"],
    name: val["task_name"],
    createdDate: val["created_date"],
    updateDate: val["update_date"],
    taskDetails: val["task_details"],
    isFavourite: val["is_favourite"],
  );

  DataMap get toJson => {
    "task_id": id,
    "task_name": name,
    "created_date": createdDate,
    "update_date": updateDate,
    "task_details": taskDetails,
    "is_favourite": isFavourite,
  };
}
