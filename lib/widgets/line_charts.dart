import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartPage extends StatefulWidget {
  List<Milk> items;
  String title;
  List<Milk> trend;

  LineChartPage(
      {required this.items, required this.title, required this.trend});

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
    return Column(
      children: [
        SfCartesianChart(
          title: ChartTitle(text: widget.title),
          indicators: <TechnicalIndicators<Milk, DateTime>>[
            AccumulationDistributionIndicator<Milk, DateTime>(
                seriesName: 'HiloOpenClose')
          ],
          tooltipBehavior: _tooltipBehavior,
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries>[
            LineSeries<Milk, String>(
                name: widget.title,
                enableTooltip: true,
                dataSource: widget.items,
                trendlines: <Trendline>[],
                xValueMapper: (Milk data, _) => data.dateTime,
                yValueMapper: (Milk data, _) => data.varible,
                color: Theme.of(context).colorScheme.primary),
            LineSeries<Milk, String>(
                enableTooltip: true,
                dataSource: widget.trend,
                xValueMapper: (Milk data, _) => data.dateTime,
                yValueMapper: (Milk data, _) => data.varible,
                color: Theme.of(context).colorScheme.error)
          ],
        ),
      ],
    );
  }
}
