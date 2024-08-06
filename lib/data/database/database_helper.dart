import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../dto/user_info.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            login TEXT PRIMARY KEY,
            id INTEGER,
            name TEXT,
            avatarUrl TEXT,
            followers INTEGER,
            following INTEGER,
            isBookmarked boolean
          )
        ''');
      },
    );
  }

  Future<int> insertTodo(UserInfo todo) async {
    Database db = await database;

    return await db.insert('todos', todo.toMap);
  }

  Future<List<UserInfo>> getTodos() async {
    Database db = await database;

    List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (index) {
      return UserInfo(
          id: maps[index]['id'],
          login: maps[index]['login'],
          name: maps[index]['name'],
          avatarUrl: maps[index]['avatarUrl'],
          followers: maps[index]['followers'],
          following: maps[index]['following'],
          isBookmarked: true);
    });
  }

  Future<void> deleteTodo(String login) async {
    Database db = await database;

    await db.delete(
      'todos', // 테이블 이름
      where: 'login = ?', // 삭제할 조건 설정
      whereArgs: [login], // 조건 값 설정
    );
  }
}
