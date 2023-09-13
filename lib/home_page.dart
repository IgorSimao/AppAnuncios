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
        backgroundColor: const Color.fromARGB(255, 242, 223, 53),
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
                  alignment: Alignment(0.9, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  _list.removeAt(position);
                });
              },
              child: ListTile(
                  title: Text(_list[position].nome),
                  subtitle: Text(_list[position].descricao +
                      "\n" +
                      "R\$${_list[position].valor.toString()}"),
                  // trailing: Icon(Icons.edit_outlined),
                  trailing: Container(
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          Produto editeProduto = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadastroScreen(
                                        produto: produto,
                                      )));
                          if (editeProduto != null) {
                            setState(() {
                              _list.removeAt(position);
                              _list.insert(position, editeProduto);
                            });
                          }
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text("Editar")),
                  ),
                  onLongPress: () async {
                    Produto editeProduto = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CadastroScreen(produto: produto)));

                    if (editeProduto != null) {
                      setState(() {
                        _list.removeAt(position);
                        _list.insert(position, editeProduto);
                      });
                    }
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 242, 223, 53),
        child: const Icon(Icons.add),
        onPressed: () async {
          try {
            Produto produto = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroScreen()));
            setState(() {
              _list.add(produto);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
      ),
    );
  }
}
