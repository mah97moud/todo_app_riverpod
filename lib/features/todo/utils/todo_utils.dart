import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TodoUtils {
  const TodoUtils._();

  static Future<List<TaskModel>> getTodayTasks(List<TaskModel> 
  allTasks,) async {
    final today = DateTime.now();
    if (allTasks.isEmpty) return allTasks;
    return allTasks
        .where(
          (task) => DateUtils.isSameDay(task.date, today),
        )
        .toList();
  }

  static Future<List<TaskModel>> getTomorrowTasks(
      List<TaskModel> allTasks,) async {
    final tomorrow = DateTime.now().add(
      const Duration(days: 1),
    );
    if (allTasks.isEmpty) return allTasks;
    return allTasks
        .where(
          (task) => DateUtils.isSameDay(
            task.date,
            tomorrow,
          ),
        )
        .toList();
  }

  static Future<List<TaskModel>> getDayAfterTomorrowTasks(
      List<TaskModel> allTasks,) async {
    final dayAfterTomorrow = DateTime.now().add(
      const Duration(days: 2),
    );
    if (allTasks.isEmpty) return allTasks;
    return allTasks
        .where(
          (task) => DateUtils.isSameDay(
            task.date,
            dayAfterTomorrow,
          ),
        )
        .toList();
  }

  static Future<List<TaskModel>> getOneMonthAgoTasks(
      List<TaskModel> allTasks,) async {
    final oneMonthAgo = DateTime.now().subtract(
      const Duration(days: 30),
    );
    if (allTasks.isEmpty) return allTasks;
    return allTasks
        .where(
          (task) =>
              task.date!.isAfter(
                oneMonthAgo,
              ) &&
              task.date!.isBefore(
                DateUtils.dateOnly(
                  DateTime.now(),
                ),
              ),
        )
        .toList();
  }

  static Future<List<TaskModel>> getCompletedTasksToDay(
      List<TaskModel> allTasks,) async {
    if (allTasks.isEmpty) return allTasks;
    final tasksForToday = await getTodayTasks(allTasks);
    allTasks = tasksForToday.where((task) => task.isCompleted).toList();
    return allTasks;
  }

  static Future<List<TaskModel>> getActiveTasksForToday(
      List<TaskModel> allTasks,) async {
    if (allTasks.isEmpty) return allTasks;
    final tasksForToday = await getTodayTasks(allTasks);
    allTasks = tasksForToday.where((task) => !task.isCompleted).toList();
    return allTasks;
  }
}
