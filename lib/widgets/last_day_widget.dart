import 'package:flutter/material.dart';
import 'package:haytek/theme/color.dart';
import 'package:haytek/widgets/gauge.dart';

Widget lastDayWidget(lastDayValue) {
  double maxMilkValu = 60;
  AppColors appColors = AppColors();

  return Container(
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: 10,
        ),
        Gauge(
            lastDayValue["last_day_average"]["milk_quantity"].substring(0, 5),
            "milk",
            <double>[0, 0.45, 1],
            appColors.listColor.getRange(0, 3).toList(),
            maxMilkValu,
            "litre",
            true),
        Gauge(
            lastDayValue["last_day_average"]["conductivity"].substring(0, 4),
            "conductivity",
            <double>[0, 0.35, 0.4, 0.55, 0.65, 1],
            appColors.listColor,
            8.5,
            "Siemens",
            false),
        Gauge(
            lastDayValue["last_highest_data"]["milk_quantity"],
            "best-animal-milk",
            <double>[0, 0.45, 1],
            appColors.listColor.getRange(0, 3).toList(),
            maxMilkValu,
            "litre",
            true),
        Gauge(
            lastDayValue["last_highest_data"]["conductivity"],
            "best-animal-conductivity",
            <double>[0, 0.35, 0.4, 0.55, 0.65, 1],
            appColors.listColor,
            10,
            "Siemens",
            false)
      ],
    ),
  );
}
