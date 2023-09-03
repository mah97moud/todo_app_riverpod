import 'package:sqflite/sqflite.dart';

import '../../features/todo/models/task_model.dart';

enum TablesNames {
  users,
  tasks,
}

class DBHelper {
  const DBHelper._();

  static Future<void> createTables(Database database) async {
    await database.execute(
      'CREATE TABLE tasks('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'title STRING,'
      'description TEXT,'
      'isCompleted INTEGER,'
      'date STRING,'
      'startTime STRING,'
      'endTime STRING,'
      'remind INTEGER,'
      'repeat INTEGER'
      ')',
    );
    await database.execute('CREATE TABLE users('
        'id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,'
        'isVerified INTEGER DEFAULT 0'
        ')');
  }

  static Future<Database> db() async {
    return openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, _) async {
        await createTables(db);
      },
    );
  }

  /// Tasks
  static Future<void> addTask(TaskModel task) async {
    final localeDb = await db();
    await localeDb.insert(
      TablesNames.tasks.name,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    final localeDb = await db();
    return await localeDb.query(
      TablesNames.tasks.name,
      orderBy: 'id',
    );
  }

  static Future<Map<String, dynamic>> getTask(int taskId) async {
    final localeDb = await db();
    final tasks = await localeDb.query(
      TablesNames.tasks.name,
      where: 'id = ?',
      whereArgs: [taskId],
      limit: 1,
    );
    if (tasks.isEmpty) return {};
    return tasks.first;
  }

  static Future<void> deleteTask(int taskId) async {
    final localeDb = await db();
    await localeDb.delete(
      TablesNames.tasks.name,
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  static Future<void> updateTask(TaskModel task) async {
    final localeDb = await db();
    await localeDb.update(
      TablesNames.tasks.name,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  /// Users

  static Future<void> createUser({required bool isVerified}) async {
    final localeDb = await db();

    final data = {
      'id': 1,
      'isVerified': isVerified ? 1 : 0,
    };

    await localeDb.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<bool> userExists() async {
    final localeDb = await db();
    final users = await localeDb.query('users');
    return users.isNotEmpty;
  }

  static Future<void> deleteUser() async {
    final localDb = await db();
    await localDb.delete('users');
  }
}
