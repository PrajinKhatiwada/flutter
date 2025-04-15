import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/parallax_background.dart';
import 'lucky_wheel.dart';
import 'lucky_wheel_segment.dart';
import '../../widgets/footer.dart';

class LuckyWheelPage extends StatefulWidget {
  const LuckyWheelPage({super.key});

  @override
  _LuckyWheelPageState createState() => _LuckyWheelPageState();
}

class _LuckyWheelPageState extends State<LuckyWheelPage> with TickerProviderStateMixin {
  late AnimationController _spinController;
  late Animation<double> _spinAnimation;

  final List<LuckyWheelSegment> segments = [
    LuckyWheelSegment(label: "Grand Prize", color: Colors.red),
    LuckyWheelSegment(label: "Free Spin", color: Colors.blue),
    LuckyWheelSegment(label: "50 Points", color: Colors.green),
    LuckyWheelSegment(label: "Try Again", color: Colors.amber),
    LuckyWheelSegment(label: "100 Points", color: Colors.purple),
    LuckyWheelSegment(label: "Mystery Box", color: Colors.teal),
    LuckyWheelSegment(label: "Jackpot!", color: Colors.pink),
    LuckyWheelSegment(label: "Better Luck", color: Colors.orange),
  ];

  String result = "";
  bool showResult = false;
  double finalAngle = 0.0;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _spinAnimation = CurvedAnimation(
      parent: _spinController,
      curve: Curves.easeOutCubic,
    );
    _spinController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showResult = true);
      }
    });
  }

  void spinWheel() {
    setState(() => showResult = false);
    _spinController.reset();

    final random = Random();
    finalAngle = random.nextDouble() * 2 * pi;
    final segmentAngle = 2 * pi / segments.length;
    final segmentIndex = ((finalAngle / segmentAngle) % segments.length).floor();
    result = segments[segmentIndex].label;

    final totalRotation = 2 * pi * (5 + random.nextInt(5)) + finalAngle;
    _spinAnimation = Tween<double>(begin: 0, end: totalRotation).animate(
      CurvedAnimation(parent: _spinController, curve: Curves.easeOutCubic),
    );
    _spinController.forward();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎡 Lucky Wheel")),
      body: Stack(
        children: [
          const ParallaxBackground(),
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _spinAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _spinAnimation.value,
                            child: LuckyWheel(size: 300, segments: segments),
                          );
                        },
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: showResult ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purpleAccent),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Congratulations!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _spinController.isAnimating ? null : spinWheel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent.shade700,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text('SPIN THE WHEEL'),
              ),
              const SizedBox(height: 30),
              const Footer(),
            ],
          ),
        ],
      ),
    );
  }
}
