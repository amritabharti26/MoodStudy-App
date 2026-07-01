import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, "moodstudy.db");

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,

      onUpgrade: (db, oldVersionn, newVersion) async {
        if (oldVersionn < 3) {
          await db.execute('''
          CREATE TABLE focus_table(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          mood TEXT,
          allocatedSeconds INTEGER,
          studiedSeconds INTEGER,
          status TEXT,
          date TEXT
          )''');
        }
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE mood_table(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mood TEXT, 
    recommendation TEXT,
    date TEXT,
    focusTime TEXT -- Added this column (Use INTEGER if storing minutes/seconds as numbers)
    )''');

    await db.execute('''
    CREATE TABLE focus_table(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mood TEXT,
    allocatedSeconds INTEGER,
    studiedSeconds INTEGER,
    status TEXT,
    date TEXT 
    )''');
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;

    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;

    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
