import 'package:flutter/material.dart';
import 'dice_dot_painter.dart';

class Dice3D extends StatelessWidget {
  final double size;
  final int value;

  const Dice3D({
    super.key,
    required this.size,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size / 6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CustomPaint(
        painter: DiceDotPainter(value: value),
        size: Size(size, size),
      ),
    );
  }
}

