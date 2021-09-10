import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';

import 'package:max_shoes_vendedor/crud/edit_produto_page.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';
import 'package:provider/provider.dart';

class TodosProdutosPage extends StatefulWidget {
  @override
  _TodosProdutosPageState createState() => _TodosProdutosPageState();
}

class _TodosProdutosPageState extends State<TodosProdutosPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );
  dynamic dropdownValue = 'Opções';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xfff8f9fa),
                Color(0xffced4da),
                Color(0xff89c2d9),
                Color(0xffa9d6e5),
              ])),
        ),
        title: const Text('Todos Produtos', style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            //filtra a coleção
            
            .collection('produtos')
            .orderBy('categoria')
            //filtra apenas a coleção do key do usuario logado
            //.where('ownerKey', isEqualTo: userController.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final produtos = snapshot.data!.docs.map((map) {
            final data = map.data();
            return ProdutoModel.fromMap(data, map.id);
          }).toList();

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ListTile(
                title: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                              Center(
                            child: Column(
                              children: [
                                
                                Column(
                                  children: [
                                    Text('Vendedor: ${userController.model.nome}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              produto.imagem != null
                                  ? Image.memory(produto.imagem!,
                                      width: 110, fit: BoxFit.cover)
                                  : Container(
                                      child:
                                          Center(child: Text('No image')),
                                      width: 110,
                                      height: 110,
                                      color: Colors.grey,
                                    ),
                              produto.imagem2 != null
                                  ? Image.memory(produto.imagem2!,
                                      width: 110, fit: BoxFit.cover)
                                  : Container(
                                      child:
                                          Center(child: Text('No image')),
                                      width: 110,
                                      height: 110,
                                      color: Colors.grey,
                                    ),
                              produto.imagem3 != null
                                  ? Image.memory(produto.imagem3!,
                                      width: 110, fit: BoxFit.cover)
                                  : Container(
                                      child:
                                          Center(child: Text('No image')),
                                      width: 110,
                                      height: 110,
                                      color: Colors.grey,
                                    ),
                            ],
                          ),
                          Center(
                            child: Column(
                              children: [
                                
                                Column(
                                  children: [
                                    Text('Produto: ${produto.nome}'),
                                    SizedBox(height: 5),
                                    Text('Categoria: ${produto.categoria}'),
                                    SizedBox(height: 5),
                                    Text('Preço R\$:${produto.preco}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        ),
                  ),
                ),
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddProduto(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

showAlertDialog3(BuildContext context, ProdutoModel produto) {
  // configura os botões
  Widget lembrarButton = TextButton(
    
    child: Text('Apagar'),
    onPressed: () {
      FirebaseFirestore.instance
          .collection('produtos')
          .doc(produto.key)
          .delete();
      Navigator.pop(context);
    },
  );
  Widget cancelaButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // configura o  AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Aviso"),
    content: Text("Deseja mesmo apagar esse produto?"),
    actions: [
      lembrarButton,
      cancelaButton,
    ],
  );
  // exibe o dialogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
