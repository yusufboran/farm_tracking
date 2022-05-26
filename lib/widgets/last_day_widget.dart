import 'package:flutter/material.dart';
import 'package:haytek/widgets/gauge.dart';

Widget lastDayWidget(lastDayValue) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 16),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("Son Günü Ortalama Verileri"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gauge(
                    lastDayValue["last_day_average"]["milk_quantity"]
                        .substring(0, 5),
                    "milk",
                    <double>[0, 0.45, 1],
                    <Color>[
                      Color(0xFFff5d75),
                      Color(0xFFf5d033),
                      Color(0xFF77dd77),
                    ],
                    50),
                Gauge(
                    lastDayValue["last_day_average"]["conductivity"]
                        .substring(0, 4),
                    "conductivity",
                    <double>[0, 0.35, 0.45, 0.55, 0.65, 1],
                    <Color>[
                      Color(0xFFff5d75),
                      Color(0xFFf5d033),
                      Color(0xFF77dd77),
                      Color(0xFF77dd77),
                      Color(0xFFf5d033),
                      Color(0xFFff5d75),
                    ],
                    10)
              ],
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 16),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("Son Günü Ortalama Verileri"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gauge(
                    lastDayValue["last_highest_data"]["milk_quantity"],
                    "best-animal-milk",
                    <double>[0, 0.45, 1],
                    <Color>[
                      Color(0xFFff5d75),
                      Color(0xFFf5d033),
                      Color(0xFF77dd77),
                    ],
                    50),
                Gauge(
                    lastDayValue["last_highest_data"]["conductivity"],
                    "best-animal-conductivity",
                    <double>[0, 0.35, 0.45, 0.55, 0.65, 1],
                    <Color>[
                      Color(0xFFff5d75),
                      Color(0xFFf5d033),
                      Color(0xFF77dd77),
                      Color(0xFF77dd77),
                      Color(0xFFf5d033),
                      Color(0xFFff5d75),
                    ],
                    10)
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
