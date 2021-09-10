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
                Color(0xff89c2d9),
                Color(0xfff8f9fa),
                Color(0xffced4da),
                Color(0xff014f86)
              ])),
        ),
        title: const Text('MaxShoes',
            style: TextStyle(fontSize: 28, color: Color(0xff343a40))),
        centerTitle: true,
      ),
      body: HistoricoPage(),
    );
  }
}
