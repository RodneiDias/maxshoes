import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/user_controller.dart';
import 'signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //essas Strings foram criadas para guardar os valores
  String email = "";
  String senha = "";

  late final userController =
      Provider.of<UserController>(context, listen: false);
  //Late é uma inicialização tardia - PofUserController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (texto) => email = texto,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                onChanged: (texto) => senha = texto,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await userController.login(email, senha);
                  } on FirebaseAuthException catch (e) {
                    var mensagem = "";

                    if (e.code == "wrong-password") {
                      mensagem = "A senha está incorreta";
                    } else if (e.code == "invalid-email") {
                      mensagem = "Email Inválido";
                    } else if (e.code == "user-not-found") {
                      mensagem = "Usuário não encontrado";
                    } else {
                      mensagem = "Ocorreu um erro";
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(mensagem),
                      ),
                    );
                  }
                },
                child: Text("Login"),
              ),
              Text("OU"),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
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
