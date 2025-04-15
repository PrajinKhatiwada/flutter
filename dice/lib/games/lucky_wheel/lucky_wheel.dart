import 'package:flutter/material.dart';
import 'lucky_wheel_segment.dart';
import 'lucky_wheel_painter.dart';

class LuckyWheel extends StatelessWidget {
  final double size;
  final List<LuckyWheelSegment> segments;

  const LuckyWheel({super.key, required this.size, required this.segments});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: CustomPaint(
        painter: LuckyWheelPainter(segments: segments),
        size: Size(size, size),
      ),
    );
  }
}
