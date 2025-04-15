import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1E293B),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: const Text(
        '© 2025 Prajin Khatiwada | Rollie Inc.',
        style: TextStyle(
          color: Colors.white60,
          fontSize: 13,
          letterSpacing: 1.1,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}