import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';
import 'package:provider/provider.dart';

class FemininoPage extends StatefulWidget {
  FemininoPage({Key? key}) : super(key: key);

  @override
  _FemininoPageState createState() => _FemininoPageState();
}

class _FemininoPageState extends State<FemininoPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f9fa),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where('ownerKey', isEqualTo: userController.user!.uid)
            .where('categoria', isEqualTo: 'feminino')
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            produto.imagem != null
                                ? Image.memory(produto.imagem!,
                                    width: 110, fit: BoxFit.cover)
                                : Container(
                                    child: Center(child: Text('No image')),
                                    width: 110,
                                    height: 110,
                                    color: Colors.grey,
                                  ),
                            produto.imagem2 != null
                                ? Image.memory(produto.imagem2!,
                                    width: 110, fit: BoxFit.cover)
                                : Container(
                                    child: Center(child: Text('No image')),
                                    width: 110,
                                    height: 110,
                                    color: Colors.grey,
                                  ),
                            produto.imagem3 != null
                                ? Image.memory(produto.imagem3!,
                                    width: 110, fit: BoxFit.cover)
                                : Container(
                                    child: Center(child: Text('No image')),
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
    );
  }
}
