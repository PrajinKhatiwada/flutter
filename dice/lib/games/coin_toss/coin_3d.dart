import 'package:flutter/material.dart';

class Coin3D extends StatelessWidget {
  final double size;
  final bool isHeads;

  const Coin3D({super.key, required this.size, required this.isHeads});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isHeads
              ? [Colors.amber.shade300, Colors.amber.shade700]
              : [Colors.amber.shade200, Colors.amber.shade600],
          center: const Alignment(0.3, -0.3),
          focal: const Alignment(0.2, -0.2),
          radius: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: isHeads ? _buildHeadsSide() : _buildTailsSide(),
      ),
    );
  }

  Widget _buildHeadsSide() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size * 0.85,
          height: size * 0.85,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.amber.shade800,
              width: 3,
            ),
          ),
        ),
        const Icon(
          Icons.face,
          size: 80,
          color: Color(0xFF704214),
        ),
        Positioned(
          top: size * 0.15,
          child: SizedBox(
            width: size * 0.5,
            child: const Text(
              "LIBERTY",
              style: TextStyle(
                color: Color(0xFF704214),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: size * 0.15,
          child: SizedBox(
            width: size * 0.5,
            child: const Text(
              "2025",
              style: TextStyle(
                color: Color(0xFF704214),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTailsSide() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size * 0.6,
          height: size * 0.6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber.shade500,
            border: Border.all(
              color: Colors.amber.shade800,
              width: 2,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.shield,
              size: 60,
              color: Color(0xFF704214),
            ),
          ),
        ),
        Container(
          width: size * 0.85,
          height: size * 0.85,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.amber.shade800,
              width: 3,
            ),
          ),
        ),
      ],
    );
  }
}
