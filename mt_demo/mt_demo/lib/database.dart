import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'transactions.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        mobileNumber TEXT,
        package TEXT,
        txid TEXT
      )
    ''');
  }

  Future<int> insertTransaction(TransactionDetails transaction) async {
    Database db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionDetails>> fetchTransactions() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return TransactionDetails(
        id: maps[i]['id'],
        date: maps[i]['date'],
        mobileNumber: maps[i]['mobileNumber'],
        package: maps[i]['package'],
        txid: maps[i]['txid'],
      );
    });
  }
}


class TransactionDetails {
  int? id; // Nullable because SQLite auto-generates IDs
  String date;
  String mobileNumber;
  String package;
  String txid;

  TransactionDetails({
    this.id,
    required this.date,
    required this.mobileNumber,
    required this.package,
    required this.txid,
  });

  // Convert a TransactionDetails object into a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'mobileNumber': mobileNumber,
      'package': package,
      'txid': txid,
    };
  }
}
