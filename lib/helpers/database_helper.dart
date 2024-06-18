import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/quote.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quotes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE quotes(id INTEGER PRIMARY KEY, text TEXT, author TEXT)',
        );
      },
    );
  }

  Future<void> insertQuote(Quote quote) async {
    final db = await database;
    await db.insert('quotes', quote.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Quote>> getQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quotes');
    return List.generate(maps.length, (i) {
      return Quote(
        text: maps[i]['text'],
        author: maps[i]['author'],
      );
    });
  }
}
