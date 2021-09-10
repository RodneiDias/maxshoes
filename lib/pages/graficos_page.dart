import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficoPage extends StatefulWidget {
  @override
  _GraficoPageState createState() => _GraficoPageState();
}

class _GraficoPageState extends State<GraficoPage> {
  late List<ExpenseData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCartesianChart(
            legend: Legend(isVisible: true), 
            backgroundColor: Colors.blue.shade200,
            series: <ChartSeries>[
              StackedColumnSeries<ExpenseData, String>(
                color: Colors.pink.shade400,
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.masculino, name: 'Masculino'),
              StackedColumnSeries<ExpenseData, String>(
                color: Colors.orange,
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.feminino, name: 'Feminino'),
              StackedColumnSeries<ExpenseData, String>(
                color: Colors.purple.shade700,
                  dataSource: _chartData,
                  xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                  yValueMapper: (ExpenseData exp, _) => exp.infantil, name: 'Infantil'),
            ],
            primaryXAxis: CategoryAxis(),
          ),
        ),
      ),
    );
  }

  List<ExpenseData> getChartData() {

    final List<ExpenseData> chartData = [

      ExpenseData('Vendas', 20, 40, 20),
      ExpenseData('Clientes', 5, 15, 5),
      ExpenseData('Capital', 7, 6, 8),
    ];
    return chartData;
  }
}

class ExpenseData {
  final String expenseCategory;
  final num masculino;
  final num feminino;
  final num infantil;

  ExpenseData(this.expenseCategory, this.masculino, this.feminino, this.infantil);
}
