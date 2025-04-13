import 'package:path/path.dart';
import 'package:posapp/feature/posapp/data/models/product_model.dart';
import 'package:posapp/feature/posapp/data/models/transaction_item_model.dart';
import 'package:posapp/feature/posapp/data/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';

class PosappLocalDatasource {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'posapp_v1.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    //PRODUCTS
    await db.execute('''CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  price REAL
);
''');
    //Transactions
    await db.execute('''CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT
);
''');
    //TRANSACTIONS ITEM
    await db.execute('''CREATE TABLE transaction_items (
  transaction_id INTEGER,
  product_id INTEGER,
  quantity INTEGER,
  PRIMARY KEY (transaction_id, product_id),
  FOREIGN KEY (transaction_id) REFERENCES transactions(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
''');
  }

  //Transactions
  Future<void> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    int transId = await db!.insert(
      'transactions',
      transaction.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (var item in transaction.items) {
      await db.insert('transaction_items', {
        'transaction_id': transId,
        'product_id': item.product.id,
        'quantity': item.quantity,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db!.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    final db = await database;
    await db!.update(
      'transactions',
      transaction.toJson(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );

    // Hapus item lama dulu biar ga numpuk
    await db.delete(
      'transaction_items',
      where: 'transaction_id = ?',
      whereArgs: [transaction.id],
    );

    // Insert ulang item baru
    for (var item in transaction.items) {
      await db.insert('transaction_items', {
        'transaction_id': transaction.id,
        'product_id': item.product.id,
        'quantity': item.quantity,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    final db = await database;
    final transactionMaps = await db!.query('transactions');
    List<TransactionModel> results = [];
    for (var map in transactionMaps) {
      final transactionId = map['id'] as int;

      // Ambil item dari transaction_items berdasarkan transaction_id
      final itemMaps = await db.query(
        'transaction_items',
        where: 'transaction_id = ?',
        whereArgs: [transactionId],
      );

      final items = <TransactionItemModel>[];

      for (var itemMap in itemMaps) {
        // Ambil detail produk dari tabel products
        final productMaps = await db.query(
          'products',
          where: 'id = ?',
          whereArgs: [itemMap['product_id']],
        );

        if (productMaps.isNotEmpty) {
          final product = ProductModel.fromJson(productMaps.first).toEntity();
          final quantity = itemMap['quantity'] as int;
          items.add(TransactionItemModel(product: product, quantity: quantity));
        }
      }

      results.add(
        TransactionModel(
          id: transactionId,
          date: DateTime.parse(map['date'] as String),
          items: items,
        ),
      );
    }
    return results;
  }

  //Product
  Future<void> insertProduct(ProductModel product) async {
    final db = await database;
    await db!.insert(
      'products',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db!.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await database;
    await db!.update(
      'products',
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('products');
    return List.generate(maps.length, (i) {
      return ProductModel.fromJson(maps[i]);
    });
  }
}
