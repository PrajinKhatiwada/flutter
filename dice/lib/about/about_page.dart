import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDarkMode ? Colors.cyanAccent : Colors.indigoAccent;
    final backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFE0E8F9);
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode 
            ? Colors.black.withOpacity(0.7) 
            : Colors.white.withOpacity(0.85),
        elevation: 0,
        title: Text(
          "About",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "🎮",
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Rollie Games",
              style: GoogleFonts.pressStart2p(
                fontSize: 24,
                color: accentColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Version 1.0.0",
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            _buildInfoSection(
              title: "About The App",
              content: "Rollie Games is a collection of simple yet fun games of chance. Use these games for decision making, game nights, or just for fun!",
              textColor: textColor,
              accentColor: accentColor,
            ),
            const SizedBox(height: 30),
            _buildInfoSection(
              title: "How To Use",
              content: "Select any game from the main menu. Each game has its own set of controls and options. Use the settings menu to customize your experience.",
              textColor: textColor,
              accentColor: accentColor,
            ),
            const SizedBox(height: 30),
            _buildInfoSection(
              title: "Developer",
              content: "Created by Prajin Khatiwada, a passionate Flutter developer with a love for creating fun and engaging applications.",
              textColor: textColor,
              accentColor: accentColor,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContactButton(
                  icon: Icons.email_outlined,
                  label: "Email",
                  accentColor: accentColor,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                _buildContactButton(
                  icon: Icons.web_outlined,
                  label: "Website",
                  accentColor: accentColor,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                _buildContactButton(
                  icon: Icons.code_outlined,
                  label: "GitHub",
                  accentColor: accentColor,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "© 2025 Prajin Khatiwada | Rollie Inc.",
              style: GoogleFonts.robotoMono(
                color: textColor.withOpacity(0.6),
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    required Color textColor,
    required Color accentColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: TextStyle(
            color: textColor.withOpacity(0.9),
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required Color accentColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}