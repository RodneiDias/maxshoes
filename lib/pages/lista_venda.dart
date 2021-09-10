import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/models/vendas_model.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ListaVendas extends StatefulWidget {
  @override
  _ListaVendasState createState() => _ListaVendasState();
}

class _ListaVendasState extends State<ListaVendas> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('vendas').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final vendas = snapshot.data!.docs.map((map) {
            final data = map.data();
            return VendasModel.fromMap(data, map.id);
          }).toList();

          return ListView.builder(
            itemCount: vendas.length,
            itemBuilder: (context, index) {
              final venda = vendas[index];

              double total = 0;
              for (var preco in vendas) {
                total += preco.preco;
              }

              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: PieChart(
                      dataMap: {
                        'Flutter': total,
                        'Maths': 4,
                        'English': 2,
                        'Android': 4
                      },
                      chartRadius: 300,
                      chartType: ChartType.ring,
                      centerText: 'Charts',
                      colorList: [
                        Colors.red,
                        Colors.green,
                        Colors.grey,
                        Colors.orange
                      ],
                      chartValuesOptions: ChartValuesOptions(
                        chartValueStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        showChartValueBackground: false,
                        showChartValuesOutside: true,
                        showChartValuesInPercentage: true,
                      ),
                      legendOptions: LegendOptions(
                        legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                      ),
                      animationDuration: Duration(milliseconds: 2000),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
