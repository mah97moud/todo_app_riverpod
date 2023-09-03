
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app_riverpod/core/helper/database_helper.dart';
import 'package:todo_app_riverpod/features/todo/models/task_model.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTasks();
    state = data
        .map(
          (taskData) => TaskModel.fromMap(taskData),
        )
        .toList();
    print('Current State: $state');
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> deleteTask(TaskModel task) async {
    await DBHelper.deleteTask(task.id!);
    refresh();
  }

  Future<void> updateTask(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }


  Future<void> markAsCompleted(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }
}
