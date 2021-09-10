import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficosPage extends StatefulWidget {
  @override
  _GraficosPageState createState() => _GraficosPageState();
}

class _GraficosPageState extends State<GraficosPage> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData(context);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCircularChart(
          title: ChartTitle(text: ''),
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<GDPData, String>(
                dataSource: _chartData,
                xValueMapper: (GDPData data, _) => data.propriedade,
                yValueMapper: (GDPData data, _) => data.gdp,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true)
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData(context) {
    final List<GDPData> chartData = [
      GDPData('Categoria', 1336),
      GDPData('Preço', 2900),
      GDPData('Quantidade', 23050),
      GDPData('Usuários', 24880),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.propriedade, this.gdp);
  final String propriedade;
  final int gdp;
}
