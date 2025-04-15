import 'dart:math';
import 'package:flutter/material.dart';

class ParallaxBackground extends StatefulWidget {
  const ParallaxBackground({Key? key}) : super(key: key);

  @override
  _ParallaxBackgroundState createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Star> _stars = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Increase the number of stars for extra density.
    for (int i = 0; i < 200; i++) {
      // Depth: lower value means closer, higher value means farther away.
      double depth = _random.nextDouble() * 0.7 + 0.3; // Range: 0.3 to 1.0
      _stars.add(
        Star(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: (_random.nextDouble() * 2 + 1) * (1 / depth), // Bigger when nearer
          speed: (_random.nextDouble() * 0.02 + 0.005) / depth, // Faster when nearer
          twinkleOffset: _random.nextDouble() * 2 * pi,
          color: _getRandomStarColor(),
          depth: depth,
        ),
      );
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to give stars a mix of soft colors
  Color _getRandomStarColor() {
    // Mostly white; occasionally a tint of blue or yellow.
    int value = _random.nextInt(100);
    if (value < 80) {
      return Colors.white;
    } else if (value < 90) {
      return Colors.blue.shade200;
    } else {
      return Colors.yellow.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: StarFieldAdvancedPainter(_stars, _controller.value),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class Star {
  double x;
  double y;
  final double size;
  final double speed;
  final double twinkleOffset;
  final Color color;
  final double depth;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.twinkleOffset,
    required this.color,
    required this.depth,
  });
}

class StarFieldAdvancedPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarFieldAdvancedPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a vertical gradient for a deeper, cosmic background.
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0F172A), Color(0xFF1E2A45)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final starPaint = Paint();

    for (final star in stars) {
      // Calculate new vertical position; stars loop when they go off screen.
      double yPos = (star.y + (animationValue * star.speed)) % 1.0;
      double xPos = star.x;

      // Adjust opacity using a sine wave for a twinkle effect.
      double twinkle = 0.5 + 0.5 * sin((animationValue * 2 * pi) + star.twinkleOffset);

      // The effective opacity is modulated by twinkle and a factor depending on depth.
      double opacity = twinkle * (1.0 / star.depth).clamp(0.3, 1.0);
      Color starColor = star.color.withOpacity(opacity.clamp(0.3, 1.0));

      // Compute the star's position on the canvas.
      Offset center = Offset(xPos * size.width, yPos * size.height);

      // Option: draw a faint trail by painting a larger, lower-opacity circle.
      canvas.drawCircle(
        center,
        star.size * 1.5,
        starPaint..color = starColor.withOpacity(0.2),
      );

      // Draw the star.
      canvas.drawCircle(
        center,
        star.size,
        starPaint..color = starColor,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldAdvancedPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.stars != stars;
  }
}
