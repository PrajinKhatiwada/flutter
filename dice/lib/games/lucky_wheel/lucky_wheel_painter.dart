import 'dart:math';
import 'package:flutter/material.dart';
import 'lucky_wheel_segment.dart';

class LuckyWheelPainter extends CustomPainter {
  final List<LuckyWheelSegment> segments;

  LuckyWheelPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final segmentCount = segments.length;
    final segmentAngle = 2 * pi / segmentCount;

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = Colors.white.withOpacity(0.7);

    canvas.drawCircle(center, radius - 5, borderPaint);

    for (int i = 0; i < segmentCount; i++) {
      final startAngle = i * segmentAngle - pi / 2;
      final segmentPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = segments[i].color.withOpacity(0.8);

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(Rect.fromCircle(center: center, radius: radius - 10),
                startAngle, segmentAngle, false)
        ..close();

      canvas.drawPath(path, segmentPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: segments[i].label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: radius * 0.8);

      final labelRadius = radius * 0.7;
      final midAngle = startAngle + segmentAngle / 2;
      final textX = center.dx + labelRadius * cos(midAngle);
      final textY = center.dy + labelRadius * sin(midAngle);

      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(midAngle + pi / 2);
      canvas.translate(-textPainter.width / 2, -textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();

      canvas.drawPath(path, Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.white);
    }

    final centerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.1, centerPaint);

    canvas.drawCircle(
      center,
      radius * 0.1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = Colors.grey.shade800,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
