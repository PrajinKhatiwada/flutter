
import 'package:flutter/material.dart';

class DiceDotPainter extends CustomPainter {
  final int value;

  DiceDotPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final double dotSize = size.width / 6;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double offset = size.width / 4;

    switch (value) {
      case 1:
        canvas.drawCircle(Offset(centerX, centerY), dotSize / 2, dotPaint);
        break;
      case 2:
        canvas.drawCircle(Offset(centerX - offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY + offset), dotSize / 2, dotPaint);
        break;
      case 3:
        canvas.drawCircle(Offset(centerX - offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX, centerY), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY + offset), dotSize / 2, dotPaint);
        break;
      case 4:
        canvas.drawCircle(Offset(centerX - offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX - offset, centerY + offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY + offset), dotSize / 2, dotPaint);
        break;
      case 5:
        canvas.drawCircle(Offset(centerX - offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX, centerY), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX - offset, centerY + offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY + offset), dotSize / 2, dotPaint);
        break;
      case 6:
        canvas.drawCircle(Offset(centerX - offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY - offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX - offset, centerY), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX - offset, centerY + offset), dotSize / 2, dotPaint);
        canvas.drawCircle(Offset(centerX + offset, centerY + offset), dotSize / 2, dotPaint);
        break;
    }
  }

  @override
  bool shouldRepaint(DiceDotPainter oldDelegate) => oldDelegate.value != value;
} 
