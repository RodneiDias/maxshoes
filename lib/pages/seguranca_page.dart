import 'dart:ui';

import 'package:flutter/material.dart';

import '../main.dart';

class SegurancaPage extends StatefulWidget {
  SegurancaPage({Key? key}) : super(key: key);

  @override
  _SegurancaPageState createState() => _SegurancaPageState();
}

class _SegurancaPageState extends State<SegurancaPage>
    with WidgetsBindingObserver {
  bool isLocked = false;
  bool biometria = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (biometria)
      setState(() {
        if (state != AppLifecycleState.resumed) isLocked = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MyApp(),
          if (isLocked) blockWidget(),
        ],
      ),
    );
  }

  // Widget informacoesWidget() {
  //   return Container(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(
  //           Icons.credit_card,
  //           size: 72,
  //           color: Colors.deepPurpleAccent.shade700,
  //         ),
  //         Text(
  //           'Informações sensíveis!',
  //           style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             fontSize: 25,
  //           ),
  //         ),
  //         ListTile(
  //           title: Text('Proteger o App por Biometria'),
  //           leading: Switch(
  //             value: biometria,
  //             onChanged: (valor) => setState(() => biometria = valor),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget blockWidget() {
    double bottom = MediaQuery.of(context).size.height / 2;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 15.0,
        sigmaY: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.shade200.withOpacity(.5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.lock, size: 36),
              Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: bottom),
                child: Text(
                  'Desbloqueie para Acessar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                icon: Icon(Icons.fingerprint),
                iconSize: 80,
                onPressed: () => setState(() => isLocked = false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}