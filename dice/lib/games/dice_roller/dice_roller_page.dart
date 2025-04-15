import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/parallax_background.dart';
import 'dice_3d.dart';

class DiceRollerPage extends StatefulWidget {
  const DiceRollerPage({super.key});

  @override
  _DiceRollerPageState createState() => _DiceRollerPageState();
}

class _DiceRollerPageState extends State<DiceRollerPage> with TickerProviderStateMixin {
  int diceCount = 1;
  List<int> diceValues = [1];
  late AnimationController _rotationController;
  late AnimationController _bounceController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _rotationAnimation = CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeOutBack,
    );
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _bounceAnimation = CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    );
  }

  void rollDice() {
    _rotationController.reset();
    _bounceController.reset();
    _rotationController.forward();
    _bounceController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        diceValues = List.generate(
          diceCount,
          (_) => Random().nextInt(6) + 1,
        );
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🎲 Dice Roller")),
      body: Stack(
        children: [
          const ParallaxBackground(),
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Number of Dice:",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(width: 20),
                    DropdownButton<int>(
                      value: diceCount,
                      dropdownColor: const Color(0xFF1E293B),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      underline: Container(height: 2, color: Colors.blueAccent),
                      onChanged: (value) {
                        setState(() {
                          diceCount = value!;
                          diceValues = List.generate(diceCount, (_) => 1);
                        });
                      },
                      items: List.generate(
                        5,
                        (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text("${index + 1}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _rotationAnimation,
                    _bounceAnimation,
                  ]),
                  builder: (context, child) {
                    return Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          diceCount,
                          (index) => Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateX(_rotationAnimation.value * 2 * pi)
                              ..rotateY(_rotationAnimation.value * 2 * pi)
                              ..rotateZ(_rotationAnimation.value * 2 * pi)
                              ..translate(
                                0.0,
                                -20.0 * _bounceAnimation.value * (1 - _bounceAnimation.value) * 4,
                                0.0,
                              ),
                            child: Dice3D(size: 100, value: diceValues[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: rollDice,
                  child: const Text('ROLL THE DICE'),
                ),
              ),
              if (diceCount > 1)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Total: ${diceValues.reduce((a, b) => a + b)}",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Container(
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
              )
            ],
          )
        ],
      ),
    );
  }
}