import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String name;
  final String createdDate;
  final String updateDate;
  final String taskDetails;
  final bool isFavourite;

  const Task({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.updateDate,
    required this.taskDetails,
    required this.isFavourite,
  });

  Task copyWith({String? name, String? details, bool? isFavourite}) => Task(
    id: id,
    name: name ?? this.name,
    createdDate: createdDate,
    updateDate: updateDate,
    taskDetails: taskDetails,
    isFavourite: isFavourite ?? this.isFavourite,
  );

  @override
  List<Object?> get props => [];
}
