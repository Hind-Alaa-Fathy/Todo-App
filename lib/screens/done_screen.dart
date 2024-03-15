import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Shared_component/taskItem.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).doneTasks;
        return tasksBuilder(
          iconIsEmpty: Icons.check_circle_outline,
          textIsEmpty: "NO Done tasks yet, Please make your task",
          tasks: tasks
        );
      },

    );
  }
}
