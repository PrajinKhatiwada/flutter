import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/parallax_background.dart';
import '../../widgets/footer.dart';
import 'spinner_wheel.dart';

class NumberSpinnerPage extends StatefulWidget {
  const NumberSpinnerPage({super.key});

  @override
  _NumberSpinnerPageState createState() => _NumberSpinnerPageState();
}

class _NumberSpinnerPageState extends State<NumberSpinnerPage> with TickerProviderStateMixin {
  late AnimationController _spinController;
  late Animation<double> _spinAnimation;
  int minValue = 1;
  int maxValue = 100;
  int currentValue = 50;
  List<int> recentResults = [];

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _spinAnimation = CurvedAnimation(
      parent: _spinController,
      curve: Curves.easeOutCubic,
    );
    _spinController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          recentResults.insert(0, currentValue);
          if (recentResults.length > 5) recentResults.removeLast();
        });
      }
    });
  }

  void spinWheel() {
    _spinController.reset();
    _spinController.forward();

    Future.delayed(const Duration(milliseconds: 2800), () {
      setState(() {
        currentValue = minValue + Random().nextInt(maxValue - minValue + 1);
      });
    });
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🔢 Number Spinner")),
      body: Stack(
        children: [
          const ParallaxBackground(),
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(child: _numberInputField("Min Value", minValue, (v) {
                      setState(() {
                        minValue = int.tryParse(v) ?? 1;
                        if (minValue >= maxValue) minValue = maxValue - 1;
                        if (minValue < 0) minValue = 0;
                      });
                    })),
                    const SizedBox(width: 20),
                    Expanded(child: _numberInputField("Max Value", maxValue, (v) {
                      setState(() {
                        maxValue = int.tryParse(v) ?? 100;
                        if (maxValue <= minValue) maxValue = minValue + 1;
                        if (maxValue > 9999) maxValue = 9999;
                      });
                    })),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _spinAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _spinAnimation.value * 10 * pi,
                        child: SpinnerWheel(
                          size: 250,
                          value: currentValue,
                          minValue: minValue,
                          maxValue: maxValue,
                        ),
                      );
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: _spinController.status == AnimationStatus.completed ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.greenAccent),
                  ),
                  child: Text(
                    currentValue.toString(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (recentResults.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Results:",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recentResults.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.greenAccent.withOpacity(0.3),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  recentResults[index].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: spinWheel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent.shade700,
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

  Widget _numberInputField(String label, int value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            controller: TextEditingController(text: value.toString()),
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
