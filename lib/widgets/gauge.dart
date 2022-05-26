import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget Gauge(value, icon) {
  return Column(
    children: [
      Container(
        width: 190,
        height: 190,
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 2000,
          axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 10,
                labelOffset: 0.07,
                offsetUnit: GaugeSizeUnit.factor,
                showTicks: false,
                ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 10,
                    gradient: SweepGradient(
                      startAngle: 0.0,
                      endAngle: 10,
                      colors: <Color>[
                        Color(0xFFff5d75), // blue f5d033
                        Color(0xFFf5d033), // blue
                        Color(0xFF77dd77), // green
                        Color(0xFF77dd77), // green
                        Color(0xFFf5d033),
                        Color(0xFFff5d75), // red
                      ],
                      stops: <double>[0, 0.35, 0.45, 0.55, 0.65, 1],
                    ),
                  ),
                ],
                pointers: <GaugePointer>[
                  MarkerPointer(
                      value: double.parse(value),
                      markerType: MarkerType.circle,
                      enableDragging: true,
                      color: Colors.indigo),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      axisValue: 5,
                      positionFactor: 0.5,
                      horizontalAlignment: GaugeAlignment.center,
                      verticalAlignment: GaugeAlignment.center,
                      widget: Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.5,
                    widget: Image.asset(
                      'assets/icons/$icon.png',
                      width: 70,
                      height: 50,
                    ),
                  )
                ])
          ],
        ),
      ),
    ],
  );
}
