import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/features/todo/app/task_provider.dart';
import 'package:todo_app_riverpod/features/todo/widgets/todo_tile.dart';

import '../../../core/resources/colours.dart';
import '../models/task_model.dart';
import '../utils/todo_utils.dart';
import '../views/add_task_screen.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    print('My Tasks ${tasks.length}');

    return FutureBuilder(
      future: TodoUtils.getCompletedTasksToDay(tasks),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Completed Tasks',
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
                  endIcon: const Icon(
                    AntDesign.checkcircle,
                    color: ColorsRes.green,
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
