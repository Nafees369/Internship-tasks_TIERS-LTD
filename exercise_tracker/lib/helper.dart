
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'exercises';
  static const String columnId = 'id';
  static const String columnTitle = 'title';

  // Private constructor to prevent direct instantiation
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Getter for the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database
  Future<Database> _initDatabase() async {
    // Get the default document directory path for the platform
    String path = await getDatabasesPath();
    String dbPath = join(path, 'exercise_tracker.db');

    // Open the database or create it if it doesn't exist
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate, // Callback when the database is created
    );
  }

  // Creates the exercises table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL
      )
    ''');
  }

  // Inserts a new exercise into the database
  Future<int> insertExercise(String title) async {
    Database db = await instance.database;
    return await db.insert(tableName, {columnTitle: title});
  }

  // Retrieves all exercises from the database
  Future<List<String>> getExercises() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return maps[i][columnTitle] as String;
    });
  }

  // Updates an existing exercise in the database
  Future<int> updateExercise(int id, String newTitle) async {
    Database db = await instance.database;
    return await db.update(
      tableName,
      {columnTitle: newTitle},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes an exercise from the database
  Future<int> deleteExercise(String title) async {
    Database db = await instance.database;
    // To delete by title, we need to first get the ID.
    // A more robust solution would be to pass the ID directly for deletion.
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      columns: [columnId],
      where: '$columnTitle = ?',
      whereArgs: [title],
    );
    if (result.isNotEmpty) {
      int idToDelete = result.first[columnId];
      return await db.delete(
        tableName,
        where: '$columnId = ?',
        whereArgs: [idToDelete],
      );
    }
    return 0; // No exercise found with that title
  }
}