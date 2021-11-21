import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaffet/my depot/shared/cubit/states.dart';
import 'package:yaffet/my depot/todo_app/shared/component.dart';
import 'package:yaffet/my depot/shared/cubit/cubit.dart';

class TaskScreen extends StatelessWidget {
  late Map model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        // var tasks = AppCubit.get(context).newTasks;
        // return tasksBuilderName(tasks: tasks);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTotalItems(context),
            Expanded(child: tasksBuilderName(tasks: tasks)),
          ],
        );
      },
    );
  }
}
