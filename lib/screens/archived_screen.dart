import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Shared_component/taskItem.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).archivedTasks;
        return tasksBuilder(
          tasks: tasks,
          textIsEmpty: "NO Archived tasks yet",
          iconIsEmpty: Icons.archive_outlined
        );
      },

    );
  }
}
