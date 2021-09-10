import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';
import 'package:provider/provider.dart';

//estamos criando uma classe pr fazer adição de produtos
class AddProduto extends StatefulWidget {
  @override
  _AddProdutoState createState() => _AddProdutoState();
}

class _AddProdutoState extends State<AddProduto> {
  //estamos criando variaveis para armazenar os valores digitados nos campos de TextField
  String nome = "",
      marca = "",
      preco = "",
      tamanho = "",
      cor = "",
      categoria = "",
      descricao = "";
  Uint8List? file;
  Uint8List? file2;
  Uint8List? file3;
  //estamos criando uma variavel userController que será instanciada em outras páginas
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );
  String dropdownValue = 'masculino';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Adicionar Produto"),
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                Color(0xff89c2d9),
                Color(0xfff8f9fa),
                Color(0xffced4da),
                Color(0xff014f86)
              ])))),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome",
                ),
                onChanged: (texto) => nome = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.location_on),
                  labelText: "Marca",
                ),
                onChanged: (texto) => marca = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Preço",
                ),
                //maxLines: 20,
                onChanged: (texto) => preco = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Tamanho",
                ),
                //maxLines: 20,
                onChanged: (texto) => tamanho = texto,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Cor",
                ),
                //maxLines: 20,
                onChanged: (texto) => cor = texto,
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     labelText: "Categoria",
              //   ),
              //   //maxLines: 20,
              //   onChanged: (texto) => categoria = texto,
              // ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (texto) {
                  setState(() {
                    dropdownValue = texto!;
                  });
                },
                items: <String>['masculino', 'infantil', 'feminino']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Descrição",
                ),
                maxLines: 10,
                onChanged: (texto) => descricao = texto,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      //abrir o explorador de arquivos:
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.image);

                      if (result != null) {
                        if (Platform.isAndroid || Platform.isIOS) {
                          final path = result.files.first.path;
                          final image = File(path);
                          final bytes = await image.readAsBytes();
                          file = bytes;
                        } else {
                          final bytes = result.files.first.bytes;
                          file = bytes;
                        }
                        setState(() {});
                      }
                      if (result != null) {
                        setState(() {
                          //pra nao pegar uma lista inteira, coloco pra pegar somente o primeiro e puxo os bytes deste arquivo
                          final bytes = result.files.first.bytes;
                          // file vai receber os bytes que acabei de puxar.
                          file = bytes;
                        });
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: file != null
                            ? Image.memory(file!, width: 90, fit: BoxFit.fill)
                            : Container(
                                child: Center(child: Icon(Icons.photo)),
                                width: 90,
                                height: 90,
                                color: Colors.grey,
                              )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () async {
                        //abrir o explorador de arquivos:
                        final result = await FilePicker.platform
                            .pickFiles(type: FileType.image);

                        if (result != null) {
                          if (Platform.isAndroid || Platform.isIOS) {
                            final path = result.files.first.path;
                            final image = File(path);
                            final bytes = await image.readAsBytes();
                            file = bytes;
                          } else {
                            final bytes = result.files.first.bytes;
                            file = bytes;
                          }
                          setState(() {});
                        }
                        if (result != null) {
                          setState(() {
                            //pra nao pegar uma lista inteira, coloco pra pegar somente o primeiro e puxo os bytes deste arquivo
                            final bytes = result.files.first.bytes;
                            // file vai receber os bytes que acabei de puxar.
                            file2 = bytes;
                          });
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: file2 != null
                              ? Image.memory(file2!,
                                  width: 90, fit: BoxFit.cover)
                              : Container(
                                  child: Center(child: Icon(Icons.photo)),
                                  width: 90,
                                  height: 90,
                                  color: Colors.grey,
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      //abrir o explorador de arquivos:
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.image);

                      if (result != null) {
                        if (Platform.isAndroid || Platform.isIOS) {
                          final path = result.files.first.path;
                          final image = File(path);
                          final bytes = await image.readAsBytes();
                          file = bytes;
                        } else {
                          final bytes = result.files.first.bytes;
                          file = bytes;
                        }
                        setState(() {});
                      }
                      if (result != null) {
                        setState(() {
                          //pra nao pegar uma lista inteira, coloco pra pegar somente o primeiro e puxo os bytes deste arquivo
                          final bytes = result.files.first.bytes;
                          // file vai receber os bytes que acabei de puxar.
                          file3 = bytes;
                        });
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: file3 != null
                            ? Image.memory(file3!, width: 90, fit: BoxFit.cover)
                            : Container(
                                child: Center(child: Icon(Icons.photo)),
                                width: 90,
                                height: 90,
                                color: Colors.grey,
                              )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () async {
                  final user = await FirebaseFirestore.instance
                      .collection('admin')
                      .doc(userController.user!.uid)
                      .get();

                  final data = user.data()!;

                  final novoProduto = ProdutoModel(
                    ownerKey: userController.user!.uid,
                    nome: nome,
                    marca: marca,
                    preco: preco,
                    tamanho: tamanho,
                    cor: cor,
                    categoria: dropdownValue,
                    descricao: descricao,
                    imagem: file,
                    imagem2: file2,
                    imagem3: file3,
                  ).toMap();

                  await FirebaseFirestore.instance
                      //coleção que queremos adicionar diarios
                      .collection('produtos')
                      .add(novoProduto);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Adicionar Produto",
                      style: TextStyle(color: Colors.black87)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
