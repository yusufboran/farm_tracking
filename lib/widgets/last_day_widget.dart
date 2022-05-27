import 'package:flutter/material.dart';
import 'package:haytek/theme/color.dart';
import 'package:haytek/widgets/gauge.dart';

Widget lastDayWidget(lastDayValue) {
  double maxMilkValu = 60;
  AppColors appColors = AppColors();

  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 16),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Son Günü Ortalama Verileri",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gauge(
                    lastDayValue["last_day_average"]["milk_quantity"]
                        .substring(0, 5),
                    "milk",
                    <double>[0, 0.45, 1],
                    appColors.listColor.getRange(0, 3).toList(),
                    maxMilkValu,
                    "litre"),
                Gauge(
                    lastDayValue["last_day_average"]["conductivity"]
                        .substring(0, 4),
                    "conductivity",
                    <double>[0, 0.35, 0.4, 0.55, 0.65, 1],
                    appColors.listColor,
                    8.5,
                    "Siemens")
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
              child: Text(
                "Son Günü En Verimli Hayvanın Verileri",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gauge(
                    lastDayValue["last_highest_data"]["milk_quantity"],
                    "best-animal-milk",
                    <double>[0, 0.45, 1],
                    appColors.listColor.getRange(0, 3).toList(),
                    maxMilkValu,
                    "litre"),
                Gauge(
                    lastDayValue["last_highest_data"]["conductivity"],
                    "best-animal-conductivity",
                    <double>[0, 0.35, 0.4, 0.55, 0.65, 1],
                    appColors.listColor,
                    10,
                    "Siemens")
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
