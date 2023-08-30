import 'package:sqflite/sqflite.dart';

class DBHelper {
  const DBHelper._();

  static Future<void> createTables(Database database) async {
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
}
