import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'pages/game_selection_page.dart';

void main() => runApp(const RollieApp());

class RollieApp extends StatelessWidget {
  const RollieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rollie - Multi-Game Suite",
      theme: rollieTheme,
      home: const GameSelectionPage(),
    );
  }
}
