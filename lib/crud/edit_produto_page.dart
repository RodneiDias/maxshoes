import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';

class EditProdutoPage extends StatefulWidget {
  final ProdutoModel produto;

  EditProdutoPage({required this.produto});

  @override
  _EditProdutoPageState createState() => _EditProdutoPageState();
}

class _EditProdutoPageState extends State<EditProdutoPage> {
  late final nomeCont = TextEditingController()..text = widget.produto.nome;
  // late final autorCont = TextEditingController()..text = widget.diario.autor;
  late final marcaCont = TextEditingController()..text = widget.produto.marca;
  late final precoCont = TextEditingController()..text = widget.produto.preco;
  late final tamanhoCont = TextEditingController()
    ..text = widget.produto.tamanho;
  late final corCont = TextEditingController()..text = widget.produto.cor;
  late final categoriaCont = TextEditingController()
    ..text = widget.produto.categoria;
  late final descricaoCont = TextEditingController()
    ..text = widget.produto.descricao;
  late Uint8List? file = widget.produto.imagem;
  late Uint8List? file2 = widget.produto.imagem2;
  late Uint8List? file3 = widget.produto.imagem3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
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
            ]))),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('produtos')
                  .doc(widget.produto.key)
                  .delete();
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              TextField(
                controller: nomeCont,
                decoration: InputDecoration(
                  labelText: "nome",
                ),
              ),
              TextField(
                controller: marcaCont,
                decoration: InputDecoration(
                  // suffixIcon: Icon(Icons.person),
                  labelText: "marca",
                ),
              ),
              TextField(
                controller: precoCont,
                decoration: InputDecoration(
                  // suffixIcon: Icon(Icons.location_on),
                  labelText: "Preço",
                ),
              ),
              TextField(
                controller: tamanhoCont,
                decoration: InputDecoration(
                  labelText: "Tamanho",
                ),
                // maxLines: 20,
              ),
              TextField(
                controller: corCont,
                decoration: InputDecoration(
                  labelText: "Cor",
                ),
                // maxLines: 20,
              ),
              TextField(
                controller: categoriaCont,
                decoration: InputDecoration(
                  labelText: "Categoria",
                ),
                // maxLines: 20,
              ),
              TextField(
                controller: descricaoCont,
                decoration: InputDecoration(
                  labelText: "Descrição",
                ),
                maxLines: 10,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      //abrir o explorador de arquivos:
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.image);
                      //ele vai verifica se é nulo, pq o usuario pode abrir a pasta e nao selecionar nada..ai daria erro.
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
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () async {
                        //abrir o explorador de arquivos:
                        final result = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        //ele vai verifica se é nulo, pq o usuario pode abrir a pasta e nao selecionar nada..ai daria erro.
                        if (result != null) {
                          if (Platform.isAndroid || Platform.isIOS) {
                            final path = result.files.first.path;
                            final image2 = File(path);
                            final bytes = await image2.readAsBytes();
                            file2 = bytes;
                          } else {
                            final bytes = result.files.first.bytes;
                            file2 = bytes;
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
                      //ele vai verifica se é nulo, pq o usuario pode abrir a pasta e nao selecionar nada..ai daria erro.
                      if (result != null) {
                        if (Platform.isAndroid || Platform.isIOS) {
                          final path = result.files.first.path;
                          final image3 = File(path);
                          final bytes = await image3.readAsBytes();
                          file3 = bytes;
                        } else {
                          final bytes = result.files.first.bytes;
                          file3 = bytes;
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
              SizedBox(
                height: 8,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () async {
                    final atualizado = ProdutoModel(
                      ownerKey: widget.produto.ownerKey,
                      nome: nomeCont.text,
                      marca: marcaCont.text,
                      preco: precoCont.text,
                      tamanho: tamanhoCont.text,
                      cor: corCont.text,
                      categoria: categoriaCont.text,
                      descricao: descricaoCont.text,
                      imagem: file,
                      imagem2: file2,
                      imagem3: file3,
                    ).toMap();
                    await FirebaseFirestore.instance
                        .collection('produtos')
                        .doc(widget.produto.key)
                        .update(atualizado);

                    Navigator.pop(context);
                  },
                  child: Text('Atualizar Produto',
                      style: TextStyle(color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }
}
