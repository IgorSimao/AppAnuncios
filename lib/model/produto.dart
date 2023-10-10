import 'dart:io';

import 'package:mercado_livre/database/produtos_helper.dart';

class Produto {
  int? id;
  late String nome;
  late String descricao;
  late double valor;
  File? image;

  Produto(this.nome, this.valor, this.descricao, {this.image, this.id});

  Produto.fromMap(Map map) {
    id = map[ProdutosHelper.idColumn];
    nome = map[ProdutosHelper.nameColumn];
    descricao = map[ProdutosHelper.descriptColumn];
    valor = map[ProdutosHelper.valueColumn];
    image = map[ProdutosHelper.imageColumn] != null
        ? File(map[ProdutosHelper.imageColumn])
        : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      ProdutosHelper.idColumn: id,
      ProdutosHelper.nameColumn: nome,
      ProdutosHelper.descriptColumn: descricao,
      ProdutosHelper.valueColumn: valor,
      ProdutosHelper.imageColumn: image != null ? image!.path : null
    };
    return map;
  }
}
