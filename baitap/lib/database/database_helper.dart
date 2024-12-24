import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Factory constructor for the singleton pattern
  factory DatabaseHelper() => _instance;

  // Private internal constructor
  DatabaseHelper._internal();

  // Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  // Insert a new todo
  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    try {
      return await db.insert('todos', todo.toMap());
    } catch (e) {
      print("Error inserting todo: $e");
      return -1; // Return -1 in case of an error
    }
  }

  // Get all todos
  Future<List<Todo>> getTodos() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('todos');
      return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
    } catch (e) {
      print("Error fetching todos: $e");
      return []; // Return an empty list in case of an error
    }
  }

  // Update a todo
  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    try {
      return await db.update(
        'todos',
        todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
      );
    } catch (e) {
      print("Error updating todo: $e");
      return 0; // Return 0 if update fails
    }
  }

  // Delete a todo
  Future<int> deleteTodo(int id) async {
    final db = await database;
    try {
      return await db.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error deleting todo: $e");
      return 0; // Return 0 if delete fails
    }
  }
}
