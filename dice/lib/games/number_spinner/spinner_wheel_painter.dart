import 'dart:math';
import 'package:flutter/material.dart';

class SpinnerWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final segmentCount = 12;
    final segmentAngle = 2 * pi / segmentCount;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(0.7);

    for (int i = 0; i < segmentCount; i++) {
      final angle = i * segmentAngle;
      final lineStart = Offset(
        center.dx + (radius * 0.3) * cos(angle),
        center.dy + (radius * 0.3) * sin(angle),
      );
      final lineEnd = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(lineStart, lineEnd, paint);
    }

    for (double ratio = 0.4; ratio <= 1.0; ratio += 0.2) {
      canvas.drawCircle(
        center,
        radius * ratio,
        paint..color = Colors.white.withOpacity(0.3 + ratio * 0.3),
      );
    }

    final pointerPaint = Paint()..color = Colors.white;
    final pointerPath = Path()
      ..moveTo(center.dx, center.dy - radius - 10)
      ..lineTo(center.dx - 10, center.dy - radius + 15)
      ..lineTo(center.dx + 10, center.dy - radius + 15)
      ..close();
    canvas.drawPath(pointerPath, pointerPaint);
  }

  @override
  bool shouldRepaint(covariant SpinnerWheelPainter oldDelegate) => false;
}
