import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/task/presentation/bloc/task_list/task_cubit.dart';
import 'package:task_management/features/task/presentation/widgets/add_task_dialog.dart';
import 'package:task_management/features/task/presentation/widgets/task_list.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    context.read<TaskCubit>().fetchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Management")),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading || state is TaskInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.tasks.isEmpty) {
            return Center(child: Text("You Don't have any task"));
          }
          return Column(
            children: [
              RefreshIndicator(
                onRefresh:
                    () async => await context.read<TaskCubit>().refresh(),
                child: TaskList(state.tasks),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AddTaskDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
