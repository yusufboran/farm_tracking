import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartPage extends StatefulWidget {
  List<Milk> items;
  LineChartPage({required this.items});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        // Enables the tooltip for all the series in chart
        tooltipBehavior: _tooltipBehavior,
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          // Initialize line series
          LineSeries<Milk, String>(
            // Enables the tooltip for individual series
            enableTooltip: true,
            dataSource: widget.items,
            xValueMapper: (Milk data, _) => data.dateTime,
            yValueMapper: (Milk data, _) => data.conductivity,
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
