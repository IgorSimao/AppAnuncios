import 'dart:ffi';
import 'package:mercado_livre/database/iproduto.dart';
import 'package:mercado_livre/database/produtos_helper.dart';

import 'cadastro_screen.dart';

import 'package:flutter/material.dart';

import 'model/produto.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Produto> _list = List.empty(growable: true);

  ProdutosHelper helper = ProdutosHelper();

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    helper.getAll().then((data) {
      setState(() {
        if (data != null) _list = data;
      });
    });
  }

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
              onDismissed: (direction) async {
                var result = await helper.delete(produto);
                if (result != null) {
                  setState(() {
                    _list.removeAt(position);
                    const snackbar = SnackBar(
                      content: Text("Produto Removido com sucesso!"),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  });
                }
              },
              child: ListTile(
                  title: Text(_list[position].nome),
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: produto.image != null
                        ? ClipOval(child: Image.file(produto.image!))
                        : Container(),
                  ),
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
                          var result = await helper.edit(editeProduto);

                          if (result != null) {
                            setState(() {
                              _list.removeAt(position);
                              _list.insert(position, editeProduto);
                              const snackbar = SnackBar(
                                content: Text("Produto Editado com sucesso!"),
                                backgroundColor: Colors.orange,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
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
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Minhas compras',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 242, 223, 53),
        child: const Icon(Icons.add),
        onPressed: () async {
          try {
            Produto produto = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroScreen()));
            Produto? savedProduto = await helper.save(produto);
            if (savedProduto != null) {
              setState(() {
                _list.add(produto);
                const snackbar = SnackBar(
                  content: Text("Produto Criado com sucesso!"),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              });
            }
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },
      ),
    );
  }
}
