import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/pages/dashboard_page.dart';
import 'package:max_shoes_vendedor/pages/graficos_page.dart';


class HistoricoPage extends StatefulWidget {
  @override
  _HistoricoPageState createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: DashBoard()),
          Expanded(
            flex: 3,
            child: GraficoPage()),
        ],
      ),
    );
  }
}
