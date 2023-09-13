import 'dart:ffi';
import 'cadastro_screen.dart';

import 'package:flutter/material.dart';

import 'model/produto.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Produto> _list = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mercado Livre",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 242, 223, 53),
      ),
      body: ListView.separated(
          itemCount: _list.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, position) {
            Produto produto = _list[position];
            return Dismissible(
              key: Key(produto.nome),
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(_list[position].nome),
                subtitle: Text(_list[position].descricao),
                trailing: Text("R\$${_list[position].valor.toString()}"),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 242, 223, 53),
        child: const Icon(Icons.add),
        onPressed: () async {
          Produto produto = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastroScreen()));
          setState(() {
            _list.add(produto);
          });
        },
      ),
    );
  }
}
