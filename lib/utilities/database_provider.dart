import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static Database? _database;
  static const String tableName = 'users';

  static Future<void> initDatabase() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
            CREATE TABLE $tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              firstName TEXT,
              lastName TEXT,
              userName TEXT,
              password TEXT,
              email TEXT,
              phone TEXT,
              pin TEXT,
              dob TEXT
            )
            ''',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUser(Map<String, dynamic> user) async {
    await _database!.insert(tableName, user);
  }

  static Future<void> updateUser(
      int id, Map<String, dynamic> updatedUser) async {
    await _database!.update(
      tableName,
      updatedUser,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteUser(int id) async {
    await _database!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> clearUserTable() async {
    await _database!.delete(tableName);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    return await _database!.query(tableName);
  }
}
