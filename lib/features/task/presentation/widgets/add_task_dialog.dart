import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/dependency_injector.dart';
import 'package:task_management/features/task/presentation/bloc/add_or_update_task/add_or_update_task_cubit.dart';
import 'package:task_management/features/task/presentation/bloc/task_list/task_cubit.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  AddTaskDialogState createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();
  late final AddOrUpdateTaskCubit cubit;

  @override
  void initState() {
    cubit = AddOrUpdateTaskCubit(
      cubit: context.read<TaskCubit>(),
      updateTaskUseCase: DependencyInjector().call(),
      addTaskUseCase: DependencyInjector().call(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrUpdateTaskCubit, AddOrUpdateTaskState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is AddOrUpdateTaskSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("${state.task.name} added successfully!")));
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AddOrUpdateTaskLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return AlertDialog(
          title: Text('Enter Details'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _detailsController,
                  decoration: InputDecoration(labelText: 'Details'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Details cannot be empty';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  String name = _nameController.text;
                  String details = _detailsController.text;
                  cubit.addTask(name: name, details: details);
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
