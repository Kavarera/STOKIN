import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stokin/features/stokin/data/models/category_model.dart';

class StokinLocalDataSource {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'stokin_app_v1.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        )
      ''');

    await db.execute('''
    CREATE TABLE products(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      quantity INTEGER,
      unit TEXT,
      categoryId INTEGER NULL,
      FOREIGN KEY (categoryId) REFERENCES categories(id)
    )''');

    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER,
        amount INTEGER,
        date TEXT,
        type TEXT,
        FOREIGN KEY (productId) REFERENCES products(id)
      )
    ''');
  }

  Future<void> deleteCategory(int id) async {
    final db = await database;
    await db!.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('categories');

    return List.generate(maps.length, (i) {
      return CategoryModel.fromJson(maps[i]);
    });
  }

  Future<void> insertCategory(CategoryModel category) async {
    final db = await database;
    await db!.insert(
      'categories',
      category.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
