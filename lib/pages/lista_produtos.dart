import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/crud/add_produto.dart';
import 'package:max_shoes_vendedor/crud/edit_produto_page.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';
import 'package:provider/provider.dart';

class ListaProduto extends StatefulWidget {
  @override
  _ListaProdutoState createState() => _ListaProdutoState();
}

class _ListaProdutoState extends State<ListaProduto> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );
  dynamic dropdownValue = 'Opções';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     children: [

      //       UserAccountsDrawerHeader(
      //           currentAccountPicture: CircleAvatar(
      //             child: Image.asset(''),

      //         ),
      //         otherAccountsPictures: [
      //           CircleAvatar(
      //             child: Icon(Icons.person_outline),
      //           )
      //         ], // outras imagens da conta
      //         accountName: Text(userController.model.nome), //nome da conta
      //         accountEmail: Text(userController.user!.email!),
      //         ),

      //       ListTile(
      //         title: Text("Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,), )
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.login_sharp),
      //         title: Text("??????????????????", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), ),
      //         onTap:(){
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //     builder: (context) => ColecaoDiarioPage(),
      //           //   ),
      //           // );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.list_alt_outlined),
      //         title: Text("!!!!!!!!!!!!!!!!!!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), ),
      //         onTap:(){
      //           // Navigator.push(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //     builder: (context) => EditProdutoPage(),
      //           //   ),
      //           // );
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.exit_to_app),
      //         title: Text("Sair", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), ),
      //         onTap:(){
      //           userController.logout();
      //         },
      //       ),

      //     ],
      //   ),
      // ),
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
                  decoration: BoxDecoration(border: Border.all(width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                          width: 100, fit: BoxFit.cover)
                                      : Container(
                                          child: Icon(Icons.location_on),
                                          width: 100,
                                          height: 100,
                                          color: Colors.blue,
                                        ),
                                  Column(
                                    children: [
                                      Text('Nome: ${produto.nome}'),
                                      SizedBox(height: 5),
                                      Text('Categoria: ${produto.categoria}'),
                                      SizedBox(height: 5),
                                      Text('Descrição ${produto.descricao}'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.settings),
                                iconSize: 24,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (texto) {
                                  setState(() {
                                    dropdownValue = texto!;
                                  });
                                  if (dropdownValue == 'Apagar') {
                                    showAlertDialog3(context, produto);

                                    // Navigator.pop(context);
                                  } else if (dropdownValue == 'Editar') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProdutoPage(produto: produto),
                                        ));
                                  }
                                },
                                items: <String>[
                                  'Opções',
                                  'Editar',
                                  'Apagar'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                // subtitle:
                //  leading: produto.imagem != null
                //      ? Image.memory(produto.imagem!,
                //          width: 72, fit: BoxFit.cover)
                //      : Container(
                //          child: Icon(Icons.location_on),
                //          width: 72,
                //          height: double.maxFinite,
                //          color: Colors.blue,
                //        ),
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) =>
                //             EditProdutoPage(produto: produto),
                //       ));
                // },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduto(),
            ),
          );
        },
      ),
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
