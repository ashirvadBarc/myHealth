import 'package:medical_app/models/userModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static Database? _database;
  static const String tableName = 'users';

  static Database? get databaseInstance => _database;

  static Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }

    try {
      _database = await openDatabase(
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
    } catch (e) {
      // Handle database initialization error
      print('Error initializing database: $e');
    }
  }

  static Future<void> insertUser(UserModel user) async {
    await _database!.insert(tableName, user.toJson());
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

  static Future<UserModel?> retrieveUserFromTable(String userName) async {
    try {
      List<Map<String, dynamic>> result = await _database!.query(
        tableName,
        where: 'userName = ?',
        whereArgs: [userName],
      );

      if (result.isNotEmpty) {
        // Assuming the query returns a single user with the provided username
        return UserModel.fromJson(result.first);
      } else {
        // User not found
        return null;
      }
    } catch (e) {
      // Handle database query error
      print('Error retrieving user: $e');
      return null;
    }
  }

  static Future<void> clearUserTable() async {
    await _database!.delete(tableName);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    return await _database!.query(tableName);
  }
}
