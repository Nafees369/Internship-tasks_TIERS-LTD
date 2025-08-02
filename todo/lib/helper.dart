import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'model/task.dart';
class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'tasks';

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'todo_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return await db.insert(tableName, task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<List<Task>> getTasksByStatus(bool isCompleted) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'isCompleted = ?',
      whereArgs: [isCompleted ? 1 : 0],
      orderBy: 'id DESC', // Order by newest first
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> searchTasks(String query) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'id DESC',
    );
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }
}
