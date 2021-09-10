import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/models/user_model.dart';
import 'package:provider/provider.dart';

class ListUsuariosPage extends StatefulWidget {
  @override
  _ListUsuariosPageState createState() => _ListUsuariosPageState();
}

class _ListUsuariosPageState extends State<ListUsuariosPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

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
        title: const Text('Todos Vendedores', style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('admin').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final usuarios = snapshot.data!.docs.map(
            (documento) {
              final dados = documento.data();
              return UserModel.fromMap(dados);
            },
          ).toList();

          return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];

                var cor = usuario.key == userController.model.key
                    ? Color(0xff468faf)
                    : Colors.white;

                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(usuario.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  tileColor: cor,
                );
              });
        },
      ),
    );
  }
}