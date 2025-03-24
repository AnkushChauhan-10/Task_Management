import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/dependency_injector.dart';
import 'package:task_management/features/task/presentation/bloc/task_list/task_cubit.dart';
import 'package:task_management/features/task/presentation/screen/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjector().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(DependencyInjector().call()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const TaskScreen(),
      ),
    );
  }
}
