import 'package:flutter/material.dart';
import 'package:mercado_livre/home_page.dart';
import 'package:mercado_livre/model/produto.dart';

class CadastroScreen extends StatelessWidget {
  final TextEditingController _produtoNomeController = TextEditingController();
  final TextEditingController _produtoDescController = TextEditingController();
  final TextEditingController _produtoValorController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cadastro de Produtos",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 242, 223, 53),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: _produtoNomeController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: "Nome do Produto",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Preenchimento Obrigatório!";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: _produtoDescController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: "Descrição do Produto",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Preenchimento Obrigatório!";
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: _produtoValorController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      labelText: "Valor do Produto",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Preenchimento Obrigatório!";
                      }
                    },
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      height: 100,
                      width: 200,
                      child: ElevatedButton(
                        child: const Text("Salvar",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            Produto produto = Produto(
                                _produtoNomeController.text,
                                _produtoDescController.text,
                                double.parse(_produtoValorController.text));
                            Navigator.pop(context, produto);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 242, 223, 53)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      height: 100,
                      width: 200,
                      child: ElevatedButton(
                        child: const Text("Calcelar",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () => {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()))
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 242, 223, 53)),
                      ),
                    ),
                  )
                ])
              ],
            ),
          ),
        ));
  }
}