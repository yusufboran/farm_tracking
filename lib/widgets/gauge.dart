import 'package:flutter/material.dart';
import 'package:haytek/widgets/hydrationpool.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget Gauge(
    value, icon, listValue, listColor, double maxGauseVal, unit, animasyon) {
  return Container(
    width: 200,
    height: 200,
    child: Stack(children: <Widget>[
      Visibility(
        visible: animasyon,
        child: HydrationPoolPage(
          value: double.parse(value) / 60,
        ),
      ),
      SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 2000,
        axes: <RadialAxis>[
          RadialAxis(
              axisLineStyle: AxisLineStyle(),
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
                    enableDragging: true,
                    markerOffset: -5,
                    color: Colors.black),
                RangePointer(value: maxGauseVal, dashArray: <double>[1, 14]),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    axisValue: maxGauseVal / 2,
                    positionFactor: 0.5,
                    horizontalAlignment: GaugeAlignment.center,
                    verticalAlignment: GaugeAlignment.center,
                    widget: Text(
                      value,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                GaugeAnnotation(
                    axisValue: maxGauseVal / 2,
                    positionFactor: 0.25,
                    horizontalAlignment: GaugeAlignment.center,
                    verticalAlignment: GaugeAlignment.center,
                    widget: Text(
                      "($unit)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    )),
                GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.6,
                  widget: Image.asset(
                    'assets/icons/$icon.png',
                    width: 80,
                    height: 60,
                  ),
                )
              ])
        ],
      ),
    ]),
  );
}
