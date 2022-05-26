import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget Gauge(value, icon, listValue, listColor, double maxGauseVal) {
  return Container(
    width: 120,
    height: 120,
    child: SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 2000,
      axes: <RadialAxis>[
        RadialAxis(
            minimum: 0,
            maximum: maxGauseVal,
            labelOffset: 0.09,
            offsetUnit: GaugeSizeUnit.factor,
            showTicks: false,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: maxGauseVal,
                gradient: SweepGradient(
                  startAngle: 0.0,
                  endAngle: 10,
                  colors: listColor,
                  stops: listValue,
                ),
              ),
            ],
            pointers: <GaugePointer>[
              MarkerPointer(
                  value: double.parse(value),
                  markerType: MarkerType.circle,
                  enableDragging: true,
                  color: Colors.indigo),
              RangePointer(value: 60, dashArray: <double>[1, 14]),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  axisValue: maxGauseVal / 2,
                  positionFactor: 0.5,
                  horizontalAlignment: GaugeAlignment.center,
                  verticalAlignment: GaugeAlignment.center,
                  widget: Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0.6,
                widget: Image.asset(
                  'assets/icons/$icon.png',
                  width: 70,
                  height: 50,
                ),
              )
            ])
      ],
    ),
  );
}
