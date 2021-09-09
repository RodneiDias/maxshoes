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
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blue,
              labelStyle: TextStyle(fontSize: 20),
              tabs: [
                Tab(child: Text("Todos os Produtos"),),
                Tab(child: Text("Masculino")),
                Tab(child: Text("Feminino")),
                Tab(child: Text("Infantil")),
              ],
            ),
            title: Text(
              "Max Shoes",
              style: TextStyle(fontSize: 28),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Tab(
                child: ListaProduto(),
              ),
              Tab(child: MasculinoPage()),
              Tab(child: FemininoPage()),
              Tab(child: InfantilPage()),
            ],
          ),
        ));
  }
}
