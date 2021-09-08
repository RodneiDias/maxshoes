import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/models/user_model.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String nome = "";
  String email = "";
  String senha = "";
  Uint8List? file;
  bool isLoading = false;

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (isLoading) CircularProgressIndicator(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (texto) => nome = texto,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (texto) => email = texto,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (texto) => senha = texto,
              ),

              SizedBox(height: 10,),

             ElevatedButton(
                onPressed: () async {
                  //abrir o explorador de arquivos:
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  //ele vai verifica se é nulo, pq o usuario pode abrir a pasta e nao selecionar nada..ai daria erro.
                  if (result != null) {
                    setState(() {
                      //pra nao pegar uma lista inteira, coloco pra pegar somente o primeiro e puxo os bytes deste arquivo
                      final bytes = result.files.first.bytes;
                      // file vai receber os bytes que acabei de puxar.
                      file = bytes;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(file != null ? Icons.check : Icons.upload),
                    Text("Adicionar imagem"),
                  ],
                ),
              ),
                  
              SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () async {
                  
                  try {
                    final user = UserModel(nome: nome);
                    setState(() {
                      isLoading = true;
                    });
                    await userController.signup(email, senha, user);
                    Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    var msg = "";

                    if (e.code == "weak-password") {
                      msg = "Senha fraca!";
                    } else if (e.code == "email-already-in-use") {
                      msg = "E-mail já cadastrado";
                    } else {
                      msg = "Ocorreu um erro";
                    }

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(msg),
                    ));
                  }
                },
                child: Text("Criar conta"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
