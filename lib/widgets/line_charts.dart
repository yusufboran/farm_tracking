import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartPage extends StatefulWidget {
  List<Milk> items;
  String title;
  List<Milk> topTrend;
  List<Milk> bottomTrend;
  LineChartPage(
      {required this.items,
      required this.title,
      required this.topTrend,
      required this.bottomTrend});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  late TooltipBehavior _tooltipBehavior;
  double min = 25;
  double max = 0;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();

    widget.items.forEach((e) {
      if (e.varible < min) {
        min = e.varible;
      }
      if (e.varible > max) {
        max = e.varible;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        SfCartesianChart(
          primaryYAxis: NumericAxis(minimum: min, maximum: max),
          backgroundColor: Colors.white,
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
              trendlines: <Trendline>[
                Trendline(type: TrendlineType.linear, color: Colors.grey)
              ],
              width: 4,
              xValueMapper: (Milk data, _) => data.dateTime,
              yValueMapper: (Milk data, _) => data.varible,
              color: Color(0xff00793b),
            ),
            LineSeries<Milk, String>(
                enableTooltip: true,
                dataSource: widget.topTrend,
                dashArray: <double>[5, 5],
                xValueMapper: (Milk data, _) => data.dateTime,
                yValueMapper: (Milk data, _) => data.varible,
                color: Colors.purple),
            LineSeries<Milk, String>(
                enableTooltip: true,
                dataSource: widget.bottomTrend,
                dashArray: <double>[5, 5],
                xValueMapper: (Milk data, _) => data.dateTime,
                yValueMapper: (Milk data, _) => data.varible,
                color: Theme.of(context).colorScheme.error)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  "--",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.error),
                ),
                Text(" Alt Trend")
              ],
            ),
            Row(
              children: [
                Text(
                  "—",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(" Trend")
              ],
            ),
            Row(
              children: [
                Text(
                  "--",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                Text(" Üst Trend")
              ],
            ),
            Row(
              children: [
                Text(
                  "~",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00793b)),
                ),
                Text(" Veri")
              ],
            )
          ],
        ),
      ],
    );
  }
}
