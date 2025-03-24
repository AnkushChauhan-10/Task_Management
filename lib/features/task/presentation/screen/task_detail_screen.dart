import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer, ReadContext;
import 'package:task_management/core/util/extensions/date_extention.dart';
import 'package:task_management/dependency_injector.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/presentation/bloc/add_or_update_task/add_or_update_task_cubit.dart';
import 'package:task_management/features/task/presentation/bloc/task_list/task_cubit.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen(this.task, {super.key});

  final Task task;

  @override
  TaskDetailsScreenState createState() => TaskDetailsScreenState();
}

class TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Task task;

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDetailsController = TextEditingController();
  late final AddOrUpdateTaskCubit cubit;

  @override
  void initState() {
    super.initState();
    task = widget.task;
    _taskNameController.text = task.name;
    _taskDetailsController.text = task.taskDetails;
    cubit = AddOrUpdateTaskCubit(
      cubit: context.read<TaskCubit>(),
      updateTaskUseCase: DependencyInjector().call(),
      addTaskUseCase: DependencyInjector().call(),
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddOrUpdateTaskCubit, AddOrUpdateTaskState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is AddOrUpdateTaskSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Task Updated successfully!')),
              );
            }
            if(state is AddOrUpdateTaskError){
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Name:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _taskNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter task name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),

                    Text(
                      'Task Details:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _taskDetailsController,
                      decoration: InputDecoration(
                        hintText: 'Enter task details',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 16),

                    Text(
                      'Created Date:  ${task.createdDate.toDate.toStringDate}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Updated Date: ${task.updateDate.toDate.toStringDate}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            cubit.updateTask(
                              task,
                              name: _taskNameController.text,
                              details: _taskDetailsController.text,
                            );
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
                if (state is AddOrUpdateTaskLoading)
                  Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
