import 'package:flutter/material.dart';
import 'package:haytek/widgets/water_view.dart';

class HydrationPoolPage extends StatefulWidget {
  double value;
  HydrationPoolPage({required this.value});

  @override
  _HydrationPoolPageState createState() => _HydrationPoolPageState();
}

class _HydrationPoolPageState extends State<HydrationPoolPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Stack(
        children: [
          ClipOval(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaterView(
                  animation: _controller,
                  progress: widget.value, //seviye
                ),
              ),
              width: 200.0,
              height: 200.0,
            ),
          ),
        ],
      ),
    );
  }
}
