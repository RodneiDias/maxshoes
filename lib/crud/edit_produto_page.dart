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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
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
              ElevatedButton(
                onPressed: () async {
                  //abrir o explorador de arquivos:
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
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
                  // if (result != null) {
                  //   setState(() {
                  //     //pra nao pegar uma lista inteira, coloco pra pegar somente o primeiro e puxo os bytes deste arquivo
                  //     final bytes = result.files.first.bytes;
                  //     // file vai receber os bytes que acabei de puxar.
                  //     file = bytes;
                  //   });
                  // }
                },
                child: Row(
                  children: [
                    Icon(file != null ? Icons.check : Icons.upload),
                    Text("Adicionar imagem"),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              OutlinedButton(
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
                    ).toMap();
                    await FirebaseFirestore.instance
                        .collection('produtos')
                        .doc(widget.produto.key)
                        .update(atualizado);

                    Navigator.pop(context);
                  },
                  child: Text('Atualizar Produto'))
            ],
          ),
        ),
      ),
    );
  }
}
