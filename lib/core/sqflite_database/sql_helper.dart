import 'package:sqflite/sqflite.dart' as sql;

import '../../auth/model/user_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        email TEXT,
        password TEXT,
        count INTEGER 
      )
      """);
  }
// id: the id of the user
// email,
// password,
// count: number of times the user has logged in.

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'my_database.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new login.
  static Future<int> createUser(UserModel data) async {
    final db = await SQLHelper.db();
    final id = await db.insert('users', data.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Update an User by email,pw.
  static Future<int> updateUser(UserModel data) async {
    final db = await SQLHelper.db();
    final result = await db.update('users', data.toMap(),
        where: "email = ? AND password = ?",
        whereArgs: [data.email, data.password]);
    return result;
  }

  // Check User exist.
  static Future<String> doesUserExist(String email, password) async {
    String message = "";
    try {
      final db = await SQLHelper.db();
      List<Map<String, dynamic>> count = await db.query('users',
          where: "email = ? AND password = ?",
          whereArgs: [email, password],
          limit: 1);
      if (count.isNotEmpty) {
        await updateUser(UserModel(
            email: email, count: count.first['count'] + 1, password: password));
        message =
            "You have logged in with Email: $email & pw: $password ${count.first['count'] + 1} times";
      } else {
        await SQLHelper.createUser(
            UserModel(email: email, count: 1, password: password));
        message =
            "You have logged in with Email: $email & pw: $password for the first time";
      }
      return message;
    } catch (error) {
      rethrow;
    }
  }

  // Update an item by id
  // static Future<int> updateUser(
  //     int id, String email, String password, int count) async {
  //   final db = await SQLHelper.db();

  //   final data = {'email': email, 'password': password, 'count': count + 1};

  //   final result =
  //       await db.update('users', data, where: "id = ?", whereArgs: [id]);
  //   return result;
  // }
}
