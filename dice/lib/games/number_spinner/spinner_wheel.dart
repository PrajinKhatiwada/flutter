import 'package:flutter/material.dart';
import 'spinner_wheel_painter.dart';

class SpinnerWheel extends StatelessWidget {
  final double size;
  final int value;
  final int minValue;
  final int maxValue;

  const SpinnerWheel({
    super.key,
    required this.size,
    required this.value,
    required this.minValue,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Colors.greenAccent, Colors.green],
          center: Alignment(0.1, 0.1),
          radius: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: CustomPaint(
        painter: SpinnerWheelPainter(),
        size: Size(size, size),
        child: Center(
          child: Container(
            width: size * 0.2,
            height: size * 0.2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: size * 0.15,
                height: size * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent.shade700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
