import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import '../widgets/parallax_background.dart';
import '../games/dice_roller/dice_roller_page.dart';
import '../games/coin_toss/coin_toss_page.dart';
import '../games/number_spinner/number_spinner_page.dart';
import '../games/lucky_wheel/lucky_wheel_page.dart';
import '../settings/settings_page.dart';
import '../about/about_page.dart';

class GameSelectionPage extends StatefulWidget {
  const GameSelectionPage({super.key});

  @override
  State<GameSelectionPage> createState() => _GameSelectionPageState();
}

class _GameSelectionPageState extends State<GameSelectionPage>
    with SingleTickerProviderStateMixin {
  bool _isDarkMode = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });

    // Apply system UI overlay style based on theme
    SystemChrome.setSystemUIOverlayStyle(
      _isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: const Color(0xFF121212),
          )
          : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: const Color(0xFFE0E8F9),
          ),
    );
  }

  void _showRateAppDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Rate Rollie Games",
              style: GoogleFonts.orbitron(
                color: _isDarkMode ? Colors.cyanAccent : Colors.indigoAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Enjoying Rollie Games? Please take a moment to rate us in the app store!",
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Later",
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey : Colors.grey.shade700,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isDarkMode ? Colors.cyanAccent : Colors.indigoAccent,
                  foregroundColor: _isDarkMode ? Colors.black : Colors.white,
                  elevation: 3,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Rate Now"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme colors
    final backgroundColor =
        _isDarkMode ? const Color(0xFF121212) : const Color(0xFFE0E8F9);

    final accentColor = _isDarkMode ? Colors.cyanAccent : Colors.indigoAccent;

    final textColor = _isDarkMode ? Colors.white : Colors.black87;

    final overlayColor =
        _isDarkMode
            ? Colors.black.withOpacity(0.6)
            : Colors.indigo.withOpacity(0.15);

    // Card colors
    final cardColors =
        _isDarkMode
            ? [
              const Color(0xFFE53935).withOpacity(0.8), // Red
              const Color(0xFFFFB300).withOpacity(0.8), // Amber
              const Color(0xFF43A047).withOpacity(0.8), // Green
              const Color(0xFF9C27B0).withOpacity(0.8), // Purple
            ]
            : [
              Colors.redAccent.shade200,
              Colors.amberAccent.shade200,
              Colors.greenAccent.shade400,
              Colors.purpleAccent.shade200,
            ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              _isDarkMode
                  ? Colors.black.withOpacity(0.7)
                  : Colors.white.withOpacity(0.85),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          title: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                "Rollie Games",
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      blurRadius: 15,
                      color: accentColor.withOpacity(0.7),
                      offset: const Offset(0, 3),
                    ),
                    Shadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: accentColor,
              ),
              onPressed: _toggleTheme,
              tooltip:
                  _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: accentColor),
              color: _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: accentColor, size: 20),
                          const SizedBox(width: 10),
                          Text('Settings', style: TextStyle(color: textColor)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'rate',
                      child: Row(
                        children: [
                          Icon(Icons.star, color: accentColor, size: 20),
                          const SizedBox(width: 10),
                          Text('Rate App', style: TextStyle(color: textColor)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'about',
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: accentColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text('About', style: TextStyle(color: textColor)),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                switch (value) {
                  case 'settings':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                    break;
                  case 'rate':
                    _showRateAppDialog();
                    break;
                  case 'about':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutPage()),
                    );
                    break;
                }
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            _isDarkMode
                ? Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0F0F1E),
                        Color(0xFF1A1A30),
                        Color(0xFF252540),
                      ],
                    ),
                  ),
                )
                : const ParallaxBackground(),
            Container(color: overlayColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 65), // Space for AppBar
                  // Header
                  ShaderMask(
                    shaderCallback:
                        (bounds) => LinearGradient(
                          colors:
                              _isDarkMode
                                  ? [Colors.cyanAccent, Colors.blueAccent]
                                  : [
                                    Colors.indigoAccent,
                                    Colors.deepPurpleAccent,
                                  ],
                        ).createShader(bounds),
                    child: Text(
                      "Choose Your Game",
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        shadows: [
                          Shadow(
                            blurRadius: 15,
                            color: accentColor.withOpacity(0.8),
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Subtitle
                  Text(
                    "Tap a card to play",
                    style: GoogleFonts.quicksand(
                      color: _isDarkMode ? Colors.white70 : Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Game cards
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildGameCard(
                          title: "Dice Roller",
                          imagePath: 'icons/dice.png',
                          description: "Roll up to 6 dice at once",
                          color: cardColors[0],
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DiceRollerPage(),
                                ),
                              ),
                        ),
                        _buildGameCard(
                          title: "Coin Toss",
                          imagePath: 'icons/coin.png',
                          description: "Heads or tails? Find out!",
                          color: cardColors[1],
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CoinTossPage(),
                                ),
                              ),
                        ),
                        _buildGameCard(
                          title: "Number Spinner",
                          imagePath: 'icons/spinner.png',
                          description: "Generate random numbers",
                          color: cardColors[2],
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NumberSpinnerPage(),
                                ),
                              ),
                        ),
                        _buildGameCard(
                          title: "Lucky Wheel",
                          imagePath: 'icons/wheel.png',
                          description: "Spin the wheel of fortune",
                          color: cardColors[3],
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LuckyWheelPage(),
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '© 2025 Prajin Khatiwada | ',
                          style: GoogleFonts.robotoMono(
                            color:
                                _isDarkMode ? Colors.white60 : Colors.black54,
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          'Rollie Inc.',
                          style: GoogleFonts.robotoMono(
                            color: accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildGameCard({
  required String title,
  required String imagePath,
  required String description,
  required Color color,
  required VoidCallback onTap,
}) {
  return Hero(
    tag: title,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: Colors.white.withOpacity(0.3),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image instead of emoji
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Game title
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Game description
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
