import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/pages/lista_venda.dart';
import 'package:max_shoes_vendedor/pages/splash_page.dart';
import 'package:provider/provider.dart';

import 'drawer_page.dart';
import 'historico_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Color(0xff0097E3), Color(0xff506AA5),Color(0xff904674),Color(0xffCA2547)
            ])          
         ),        
     ),
        title: const Text('MaxShoes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await userController.logout();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SplashPage(),
    );
  }
}
