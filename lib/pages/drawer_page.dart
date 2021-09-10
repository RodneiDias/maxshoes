import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/pages/telas_page.dart';
import 'package:max_shoes_vendedor/pages/todos_produtos_page.dart';
import 'package:max_shoes_vendedor/pages/todos_vendedores_page.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  Uint8List? file;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Color(0xfff8f9fa),
                Color(0xffced4da),
                Color(0xff89c2d9),
                Color(0xff014f86),
              ],
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              tileMode: TileMode.clamp),
        ),
        child: ListView(children: [
          GestureDetector(
            onTap: () async {
              //abrir o explorador de arquivos:
              final result =
                  await FilePicker.platform.pickFiles(type: FileType.image);
              
               if (result != null) {
                 if (Platform.isAndroid || Platform.isIOS) {
                   final path = result.files.first.path;
                   final image = File(path);
                   final bytes = await image.readAsBytes();
                   file = bytes;
                 } else {
                   final bytes = result.files.first.bytes;
                   file = bytes;
                 }
                 setState(() {});
               }
              if (result != null) {
                setState(() {
                  //pra nao pegar uma lista inteira, coloco pra pegar somente o primeiro e puxo os bytes deste arquivo
                  final bytes = result.files.first.bytes;
                  // file vai receber os bytes que acabei de puxar.
                  file = bytes;
                });
              }
            },
            child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: file != null
                    ? Image.memory(
                      file!,
                      width: 110,
                      fit: BoxFit.fill,
                    )
                    : Icon(Icons.person),
              ),
              accountName: Text(
                userController.model.nome,
                style: TextStyle(fontSize: 20),
              ),
              accountEmail: Text(
                userController.user!.email!,
                style: TextStyle(fontSize: 18),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xfff8f9fa),
                      Color(0xffced4da),
                      Color(0xff89c2d9),
                      Color(0xff014f86),
                    ],
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    tileMode: TileMode.clamp),
              ),
              currentAccountPictureSize: Size.square(72),
            ),
          ),
          Divider(
            endIndent: 50,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Lista de Produtos',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelasPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Todos produtos',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosProdutosPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Todos Vendedores',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListUsuariosPage(),
                ),
              );
            },
          ),
          Divider(
            height: 4,
            thickness: 4,
            indent: 4,
            endIndent: 4,
          ),
          ListTile(
            title: Text(
              'Log Out',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () async {
              await userController.logout();
            },
            leading: Icon(Icons.exit_to_app),
          ),
        ]),
      ),
    );
  }
}
