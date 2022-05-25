import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget Gauge(value) {
  return Container(
    width: 130,
    height: 130,
    child: SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 2000,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 10,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 10,
              gradient: SweepGradient(
                startAngle: 0.0,
                endAngle: 10,
                colors: <Color>[
                  Color(0xFFEA4335), // blue
                  Colors.yellow, // blue
                  Color(0xFF34A853), // green
                  Color(0xFF34A853), // green
                  Colors.yellow, // green
                  Color(0xFFEA4335), // red
                ],
                stops: <double>[0, 0.35, 0.45, 0.55, 0.65, 1],
              ),
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: double.parse(value),
              needleStartWidth: 0,
              needleEndWidth: 5,
              needleColor: Colors.black,
              knobStyle: KnobStyle(
                  color: Colors.black,
                  borderColor: Colors.black,
                  knobRadius: 0.06,
                  borderWidth: 0.04),
              tailStyle: TailStyle(color: Colors.white, width: 5, length: 0.15),
            )
          ],
        )
      ],
    ),
  );
}
