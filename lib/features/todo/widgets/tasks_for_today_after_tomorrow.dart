import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/core/extensions/date_extensions.dart';
import 'package:todo_app_riverpod/features/todo/widgets/task_expansion_tile.dart';
import 'package:todo_app_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../core/resources/colours.dart';
import '../app/task_provider.dart';
import '../models/task_model.dart';
import '../utils/todo_utils.dart';
import '../views/add_task_screen.dart';

class TasksForTodayAfterTomorrow extends ConsumerWidget {
  const TasksForTodayAfterTomorrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return FutureBuilder(
      future: TodoUtils.getDayAfterTomorrowTasks(tasks),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final color = ColorsRes.randomColor();
          return TaskExpansionTile(
            title: "${snapshot.data!.isNotEmpty?
             snapshot.data!.first.date.dateOnly: ""} Tasks",
            subTitle: "Excluded today's and tomorrow's tasks",
            color: color,
            children: snapshot.data!.map((task) {
              final isLast =
                  snapshot.data!.indexOf(task) == snapshot.data!.length - 1;
              return TodoTile(
                task: task,
                bottomMargin: isLast ? null : 10.0,
                color: color,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddOrEditTaskScreen(
                        task: task,
                      ),
                    ),
                  );
                },
                onDelete: () {
                  ref.read(taskProvider.notifier).deleteTask(task);
                },
                endIcon: Switch(
                  value: task.isCompleted,
                  onChanged: (_) {
                    task.isCompleted = true;
                    ref.read(taskProvider.notifier).markAsCompleted(task);
                  },
                ),
              );
            }).toList(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
