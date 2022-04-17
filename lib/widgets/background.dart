import 'dart:math';

import 'package:flutter/material.dart';
import 'package:haytek/widgets/custom_clipper.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -MediaQuery.of(context).size.height * .15,
      right: -MediaQuery.of(context).size.width * .4,
      child: Container(
          child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xff14279B),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
