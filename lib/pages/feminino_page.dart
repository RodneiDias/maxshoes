import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';

class FemininoPage extends StatefulWidget {
  FemininoPage({Key? key}) : super(key: key);

  @override
  _FemininoPageState createState() => _FemininoPageState();
}

class _FemininoPageState extends State<FemininoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffa9d6e5),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  produto.imagem != null
                                      ? Image.memory(produto.imagem!,
                                          width: 120, fit: BoxFit.cover)
                                      : Container(
                                          child:
                                              Center(child: Text('No image')),
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey,
                                        ),
                                  produto.imagem2 != null
                                      ? Image.memory(produto.imagem2!,
                                          width: 120, fit: BoxFit.cover)
                                      : Container(
                                          child:
                                              Center(child: Text('No image')),
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey,
                                        ),
                                  produto.imagem3 != null
                                      ? Image.memory(produto.imagem3!,
                                          width: 120, fit: BoxFit.cover)
                                      : Container(
                                          child:
                                              Center(child: Text('No image')),
                                          width: 120,
                                          height: 120,
                                          color: Colors.grey,
                                        ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
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
                        ]),
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
