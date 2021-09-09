import 'dart:typed_data';

import 'package:max_shoes_vendedor/controllers/user_controller.dart';

import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0xffCA2547),Color(0xff904674),Color(0xff506AA5),Color(0xff0097E3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.clamp),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 132),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.topCenter,
                child: Image(
                    height:
                        MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/shoes.gif')),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              margin: EdgeInsets.only(top: 220, right: 30, bottom: 30, left: 30),
              child: Column(
                children: [
                  if (isLoading) CircularProgressIndicator(),
                  Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (texto) => nome = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.black,
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.red,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (texto) => email = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.red,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (texto) => senha = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.black,
                        ),
                        hintText: 'Senha',
                        hintStyle: TextStyle(
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xff8ACEF0), 
                    ),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
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
                      // child: Text("Criar conta"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}