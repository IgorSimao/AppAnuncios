import 'package:mercado_livre/model/produto.dart';

abstract class IProduto {
  Future<Produto?> save(Produto produto);
  Future<List<Produto>> getAll();
  Future<Produto?> getById(int id);
  Future<int?> edit(Produto produto);
  Future<int?> delete(Produto produto);
}
