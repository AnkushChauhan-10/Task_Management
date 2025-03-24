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
      body: BlocConsumer<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading || state is TaskInitial) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async => await context.read<TaskCubit>().refresh(),
            child:
                state.tasks.isEmpty
                    ? Center(child: Text("You Don't have any task"))
                    : TaskList(state.tasks),
          );
        },
        listener: (BuildContext context, TaskState state) {
          if (state is TaskError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
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
