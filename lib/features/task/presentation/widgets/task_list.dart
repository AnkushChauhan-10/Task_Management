import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/dependency_injector.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/presentation/bloc/add_or_update_task/add_or_update_task_cubit.dart';
import 'package:task_management/features/task/presentation/bloc/task_list/task_cubit.dart';
import 'package:task_management/features/task/presentation/screen/task_detail_screen.dart';
import 'package:task_management/features/task/presentation/widgets/favourite_button.dart';

class TaskList extends StatelessWidget {
  const TaskList(this.list, {super.key});

  final List<Task> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var task = list[index];
        var cubit = AddOrUpdateTaskCubit(
          cubit: context.read<TaskCubit>(),
          updateTaskUseCase: DependencyInjector().call(),
          addTaskUseCase: DependencyInjector().call(),
        );
        return ListTile(
          contentPadding: EdgeInsets.all(8),
          title: Text(task.name),
          trailing: FavouriteButton(task: task, cubit),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskDetailsScreen(task)),
            );
          },
        );
      },
    );
  }
}
