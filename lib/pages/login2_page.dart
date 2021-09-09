import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cadastro2_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
  String error = "";

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
                  colors: <Color>[
                    Color(0xfff8f9fa),
                    Color(0xffced4da),
                    Color(0xff89c2d9),
                    Color(0xffa9d6e5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.clamp),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 70),
              alignment: Alignment.topCenter,
              child: Image(
                  height:
                      MediaQuery.of(context).size.height > 800 ? 350.0 : 300,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/shoes1.gif')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              margin:
                  EdgeInsets.only(top: 320, right: 30, bottom: 30, left: 30),
              child: Column(
                children: [
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
                    // margin: EdgeInsets.only(top: 10),
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
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color(0xff468faf),
                    ),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
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
                    ),
                  ),
                  SizedBox(height: 10.0),
                  MaterialButton(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
