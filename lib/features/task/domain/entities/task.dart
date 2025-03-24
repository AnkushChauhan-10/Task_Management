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

  @override
  List<Object?> get props => [];
}
