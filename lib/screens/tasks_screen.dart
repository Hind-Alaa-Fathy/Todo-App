import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import '../Shared_component/taskItem.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = TodoCubit.get(context).newTasks;
          return tasksBuilder(
            tasks: tasks,
            iconIsEmpty: Icons.task_outlined,
            textIsEmpty: "NO tasks yet, Please add some tasks"
          );
        },

    );
  }
}
