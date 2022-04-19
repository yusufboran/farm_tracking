import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/widgets/line_charts.dart';

class AnimalDetailScreen extends StatefulWidget {
  String animalId;
  List<MilkQuantity> milkQuantity = [];
  List<MilkConductivity> milkConductivity = [];
  List<TrendValue> topTrendQuantity = [];
  List<TrendValue> topTrendConductivity = [];
  List<TrendValue> bottomTrendQuantity = [];
  List<TrendValue> bottomTrendConductivity = [];
  AnimalDetailScreen({
    required this.animalId,
    required this.milkQuantity,
    required this.milkConductivity,
    required this.topTrendConductivity,
    required this.bottomTrendQuantity,
    required this.topTrendQuantity,
    required this.bottomTrendConductivity,
  });
  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animalId),
      ),
      body: ListView(
        children: [
          LineChartPage(
              items: widget.milkQuantity,
              bottomTrend: widget.bottomTrendQuantity,
              topTrend: widget.topTrendQuantity,
              title: "Hayvana Ait Süt Verileri"),
          LineChartPage(
              items: widget.milkConductivity,
              bottomTrend: widget.bottomTrendConductivity,
              topTrend: widget.topTrendConductivity,
              title: "Hayvana Ait Sütün İletkenlik Verileri"),
        ],
      ),
    );
  }
}
