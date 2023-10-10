import 'package:flutter/material.dart';
import 'package:mercado_livre/database/produtos_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  Database? _db;

  static final DataBaseHelper _instance = DataBaseHelper.internal();

  factory DataBaseHelper() => _instance;

  DataBaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDB();
      return _db;
    }
  }

  Future<Database?> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "produtos.db");

    try {
      return _db = await openDatabase(path,
          version: 1, onCreate: _onCreateDB, onUpgrade: _onUpgradeDB);
    } catch (e) {
      print(e);
    }
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(ProdutosHelper.createScript);
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE produtos");
    await _onCreateDB(db, newVersion);
  }
}
