import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/widgets/line_charts.dart';

class AnimalDetailScreen extends StatefulWidget {
  String animalId;
  List<MilkQuantity> milkQuantity = [];
  List<MilkConductivity> milkConductivity = [];
  List<TrendValue> trendQuantity = [];
  List<TrendValue> trendConductivity = [];
  AnimalDetailScreen({
    required this.animalId,
    required this.milkQuantity,
    required this.milkConductivity,
    required this.trendQuantity,
    required this.trendConductivity,
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
              trend: widget.trendQuantity,
              title: "Hayvana Ait Süt Verileri"),
          LineChartPage(
              items: widget.milkConductivity,
              trend: widget.trendConductivity,
              title: "Hayvana Ait Sütün İletkenlik Verileri"),
        ],
      ),
    );
  }
}
