import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/parallax_background.dart';
import 'coin_3d.dart';
import '../../widgets/footer.dart';

class CoinTossPage extends StatefulWidget {
  const CoinTossPage({super.key});

  @override
  _CoinTossPageState createState() => _CoinTossPageState();
}

class _CoinTossPageState extends State<CoinTossPage> with TickerProviderStateMixin {
  bool isHeads = true;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  int headsCount = 0;
  int tailsCount = 0;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _flipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeOutBack,
    );
  }

  void flipCoin() {
    _flipController.reset();
    _flipController.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isHeads = Random().nextBool();
        isHeads ? headsCount++ : tailsCount++;
      });
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🪙 Coin Toss")),
      body: Stack(
        children: [
          const ParallaxBackground(),
          Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatContainer("Heads", headsCount, Colors.amberAccent),
                    _buildStatContainer("Tails", tailsCount, Colors.blueAccent),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _flipAnimation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(_flipAnimation.value * pi * 6),
                        child: Coin3D(
                          size: 200,
                          isHeads: isHeads,
                        ),
                      );
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _flipController.status == AnimationStatus.completed ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  isHeads ? "HEADS" : "TAILS",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isHeads ? Colors.amberAccent : Colors.blueAccent,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: flipCoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent.shade700,
                ),
                child: const Text('FLIP COIN'),
              ),
              const SizedBox(height: 30),
              const Footer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatContainer(String label, int count, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
