import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mercado_livre/home_page.dart';
import 'package:mercado_livre/model/produto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CadastroScreen extends StatefulWidget {
  Produto? produto;
  CadastroScreen({this.produto});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _produtoNomeController = TextEditingController();
  final TextEditingController _produtoDescController = TextEditingController();
  final TextEditingController _produtoValorController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.produto != null) {
      setState(() {
        _produtoNomeController.text = widget.produto!.nome;
        _produtoDescController.text = widget.produto!.descricao;
        _produtoValorController.text = widget.produto!.valor.toString();
        _image = widget.produto!.image;
      });
    }
  }

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
          backgroundColor: const Color.fromARGB(255, 242, 223, 53),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 187, 186, 186),
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 91, 91, 91)),
                  shape: BoxShape.circle,
                ),
                child: _image == null
                    ? const Icon(
                        Icons.add_a_photo_outlined,
                        size: 30,
                      )
                    : ClipOval(
                        child: Image.file(_image!),
                      ),
              ),
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: _produtoNomeController,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        labelText: "Nome do Produto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: _produtoDescController,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        labelText: "Descrição do Produto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: _produtoValorController,
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Valor do Produto",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        height: 100,
                        width: 200,
                        child: ElevatedButton(
                          child: const Text("Salvar",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () async {
                            File? savedImage;
                            if (_image != null) {
                              Directory directory =
                                  await getApplicationDocumentsDirectory();
                              String localPath = directory.path;

                              String uniqueID = UniqueKey().toString();

                              savedImage = await _image!
                                  .copy("$localPath/image_$uniqueID.jpg");
                            }

                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              if (widget.produto == null) {
                                Produto produto = Produto(
                                    _produtoNomeController.text,
                                    double.parse(_produtoValorController.text),
                                    _produtoDescController.text,
                                    image: savedImage);
                                Navigator.pop(context, produto);
                              } else {
                                //Editar Produto
                                widget.produto!.nome =
                                    _produtoNomeController.text;
                                widget.produto!.descricao =
                                    _produtoDescController.text;
                                widget.produto!.valor =
                                    double.parse(_produtoValorController.text);
                                widget.produto!.image = savedImage;
                                Navigator.pop(context, widget.produto); 
                                
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 242, 223, 53)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
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
                              backgroundColor:
                                  const Color.fromARGB(255, 242, 223, 53)),
                        ),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ],
        )));
  }
}
