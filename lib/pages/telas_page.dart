import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:provider/provider.dart';

import 'feminino_page.dart';
import 'infantil_page.dart';
import 'lista_produtos.dart';
import 'masculino_page.dart';

class TelasPage extends StatefulWidget {
  @override
  _TelasPageState createState() => _TelasPageState();
}

class _TelasPageState extends State<TelasPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(child: Text("Todos os Produtos")),
                Tab(child: Text("Masculino")),
                Tab(child: Text("Feminino")),
                Tab(child: Text("Infantil")),
              ],
            ),
            title: Text("Max Shoes"),
          ),
          body: TabBarView(
            children: [
              Tab(child: ListaProduto(),),
              Tab(child: MasculinoPage()),
              Tab(child: FemininoPage()),
              Tab(child: InfantilPage()),
            ],
          ),
        )
    );
  }
}