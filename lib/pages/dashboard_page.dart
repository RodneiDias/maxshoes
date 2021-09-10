import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DashBoard extends StatefulWidget {

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Container(
          child: PieChart(
            dataMap: {'G. produtos': 10, 'Masculino': 4, 'Feminino': 2, 'Infantil': 4},
            chartRadius: 150,
            chartType: ChartType.ring,
            centerText: 'Rotatividade',
            colorList: [Colors.blue.shade400, Colors.pink.shade400, Colors.orange, Colors.purple.shade700],
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
              legendTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              legendPosition: LegendPosition.right,
              showLegends: true,
            ),
            animationDuration: Duration(milliseconds: 8000),
          ),
        ),
      ),
    );
  }
}
