import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/models/user_model.dart';
import 'package:provider/provider.dart';

class Usuario extends StatefulWidget {
  Usuario({Key? key}) : super(key: key);

  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Usuarios'),
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            //ele traz a informação uma vez
            future: FirebaseFirestore.instance.collection('usuarios').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return DrawerHeader(
                    child: Center(child: CircularProgressIndicator()));
              }

              final usuario = snapshot.data!.docs.map((map) {
                final data = map.data();
                return UserModel.fromMap(data);
              }).toList();

              return ListView.builder(
                  itemCount: usuario.length,
                  itemBuilder: (context, index) {
                    final usuarios = usuario[index];
                    if (usuarios.nome == userController.model.nome) {
                      return Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Text(userController.model.nome,
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 25)),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Text(
                          usuarios.nome,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  });
            }));
  }
}
