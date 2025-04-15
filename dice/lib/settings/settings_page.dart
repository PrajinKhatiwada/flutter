import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  double _animationSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
      _animationSpeed = prefs.getDouble('animationSpeed') ?? 1.0;
    });
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDarkMode ? Colors.cyanAccent : Colors.indigoAccent;
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFE0E8F9);
    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode 
            ? Colors.black.withOpacity(0.7) 
            : Colors.white.withOpacity(0.85),
        elevation: 0,
        title: Text(
          "Settings",
          style: GoogleFonts.orbitron(
            color: accentColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingCard(
            title: "Appearance",
            icon: Icons.color_lens_outlined,
            color: accentColor,
            cardColor: cardColor,
            textColor: textColor,
            children: [
              SwitchListTile(
                title: Text(
                  "Dark Mode",
                  style: TextStyle(color: textColor),
                ),
                subtitle: Text(
                  "Switch between light and dark theme",
                  style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
                ),
                value: _isDarkMode,
                activeColor: accentColor,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  _saveSetting('isDarkMode', value);
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildSettingCard(
            title: "Game Settings",
            icon: Icons.games_outlined,
            color: accentColor,
            cardColor: cardColor,
            textColor: textColor,
            children: [
              SwitchListTile(
                title: Text(
                  "Sound Effects",
                  style: TextStyle(color: textColor),
                ),
                subtitle: Text(
                  "Enable or disable game sounds",
                  style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
                ),
                value: _soundEnabled,
                activeColor: accentColor,
                onChanged: (value) {
                  setState(() {
                    _soundEnabled = value;
                  });
                  _saveSetting('soundEnabled', value);
                },
              ),
              SwitchListTile(
                title: Text(
                  "Vibration",
                  style: TextStyle(color: textColor),
                ),
                subtitle: Text(
                  "Enable or disable haptic feedback",
                  style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
                ),
                value: _vibrationEnabled,
                activeColor: accentColor,
                onChanged: (value) {
                  setState(() {
                    _vibrationEnabled = value;
                  });
                  _saveSetting('vibrationEnabled', value);
                },
              ),
              ListTile(
                title: Text(
                  "Animation Speed",
                  style: TextStyle(color: textColor),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adjust the speed of game animations",
                      style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
                    ),
                    Slider(
                      min: 0.5,
                      max: 2.0,
                      divisions: 3,
                      value: _animationSpeed,
                      activeColor: accentColor,
                      label: _getAnimationSpeedLabel(),
                      onChanged: (value) {
                        setState(() {
                          _animationSpeed = value;
                        });
                      },
                      onChangeEnd: (value) {
                        _saveSetting('animationSpeed', value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildSettingCard(
            title: "About",
            icon: Icons.info_outline,
            color: accentColor,
            cardColor: cardColor,
            textColor: textColor,
            children: [
              ListTile(
                title: Text(
                  "Version",
                  style: TextStyle(color: textColor),
                ),
                trailing: Text(
                  "1.0.0",
                  style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  "Developer",
                  style: TextStyle(color: textColor),
                ),
                trailing: Text(
                  "Prajin Khatiwada",
                  style: TextStyle(color: accentColor),
                ),
              ),
              ListTile(
                title: Text(
                  "Copyright",
                  style: TextStyle(color: textColor),
                ),
                trailing: Text(
                  "2025 Rollie Inc.",
                  style: TextStyle(color: accentColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color cardColor,
    required Color textColor,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  String _getAnimationSpeedLabel() {
    if (_animationSpeed <= 0.5) return 'Slow';
    if (_animationSpeed <= 1.0) return 'Normal';
    if (_animationSpeed <= 1.5) return 'Fast';
    return 'Very Fast';
  }
}