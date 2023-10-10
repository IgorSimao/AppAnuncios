import 'package:mercado_livre/database/database_helper.dart';
import 'package:mercado_livre/database/iProduto.dart';
import 'package:mercado_livre/model/produto.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosHelper implements IProduto{
  static final String tableName = "produtos";
  static final String idColumn = "id";
  static final String nameColumn = "nome";
  static final String descriptColumn = "descricao";
  static final String valueColumn = "valor";
  static final String imageColumn = "imagem";

  static get createScript {
    return "CREATE TABLE $tableName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "$nameColumn TEXT NOT NULL, $descriptColumn TEXT NOT NULL, $valueColumn FLOAT NOT NULL, $imageColumn STRING NULL);";
  }

  @override
  Future<Produto?> save(Produto produto) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      produto.id = await db.insert(tableName, produto.toMap());
      return produto;
    }
    return null;
  }

  @override
  Future<int?> delete(Produto produto) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      return await db.delete(tableName, where: "id=?", whereArgs: [produto.id]);
    }
  }

  @override
  Future<int?> edit(Produto produto) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      return await db.update(tableName, produto.toMap(),
          where: "id=?", whereArgs: [produto.id]);
    }
  }

  @override
  Future<List<Produto>> getAll() async {
    Database? db = await DataBaseHelper().db;
    List<Produto> produtos = List.empty(growable: true);
    if (db != null) {
      List<Map> returnedProdutos = await db.query(tableName, columns: [
        idColumn,
        nameColumn,
        descriptColumn,
        valueColumn,
        imageColumn
      ]);

      for (Map mProduto in returnedProdutos) {
        produtos.add(Produto.fromMap(mProduto));
      }
    }
    return produtos;
  }

  @override
  Future<Produto?> getById(int id) async {
    Database? db = await DataBaseHelper().db;
    if (db != null) {
      List<Map> returnedProduto = await db.query(tableName,
          columns: [
            idColumn,
            nameColumn,
            descriptColumn,
            valueColumn,
            imageColumn
          ],
          where: "id=?",
          whereArgs: [id]);

      return Produto.fromMap(returnedProduto.first);
    }

    return null;
  }
}
