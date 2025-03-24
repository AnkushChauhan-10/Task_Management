import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/task/domain/entities/task.dart';
import 'package:task_management/features/task/presentation/bloc/add_or_update_task/add_or_update_task_cubit.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton(this.cubit, {super.key, required this.task});

  final AddOrUpdateTaskCubit cubit;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrUpdateTaskCubit, AddOrUpdateTaskState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is AddOrUpdateTaskLoading) return CircularProgressIndicator();
        return IconButton(
          onPressed: () => cubit.changeIsFavourite(task),
          icon: Icon(
            task.isFavourite ? Icons.favorite : Icons.favorite_border,
          ),
        );
      },
    );
  }
}
