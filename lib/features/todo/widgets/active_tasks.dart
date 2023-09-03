import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/features/todo/utils/todo_utils.dart';
import 'package:todo_app_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../core/resources/colours.dart';
import '../app/task_provider.dart';
import '../models/task_model.dart';
import '../views/add_task_screen.dart';

class ActiveTasks extends ConsumerWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    print('My Tasks ${tasks.length}');

    return FutureBuilder(
      future: TodoUtils.getActiveTasksForToday(tasks),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Active Tasks',
                style: GoogleFonts.poppins(
                  fontSize: 18.0,
                  color: ColorsRes.light.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return ColoredBox(
            color: ColorsRes.lightBackground,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final task = snapshot.data![index];
                final isLast = index == snapshot.data!.length - 1;
                return TodoTile(
                  task: task,
                  bottomMargin: isLast ? null : 10.0,
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
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
