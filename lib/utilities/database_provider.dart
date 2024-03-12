import 'package:medical_app/constants/db_const.dart';
import 'package:medical_app/models/userModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();

    return await openDatabase(
      join(path, 'app_database.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
              CREATE TABLE $userTableName(
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
    );
  }

  Future<bool> insertUser(UserModel user) async {
    try {
      final db = await initializedDB();
      await db.insert(userTableName, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return true;
    } catch (e) {
      print('---------------error during user insert--------$e');

      return false;
    }
  }

  // delete db
  Future<void> deleteUser(int id) async {
    final db = await initializedDB();
    await db.delete(
      userTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // clean db
  Future<void> clearUserTable() async {
    final db = await initializedDB();
    await db.delete(userTableName);
  }

  // retrieve data from database

  Future<UserModel> retrieveUserFromTabe() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult =
        await db.query(userTableName);

    if (queryResult.isNotEmpty) {
      return queryResult.map((e) => UserModel.fromJson(e)).first;
    } else {
      return UserModel();
    }
  }
}
