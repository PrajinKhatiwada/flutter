import 'package:flutter/material.dart';

void main() {
  runApp(ScoreApp());
}

class ScoreApp extends StatelessWidget {
  const ScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Score Tracker",
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: ScoreHome(),
    );
  }
}

class ScoreHome extends StatefulWidget {
  const ScoreHome({super.key});

  @override
  _ScoreHomeState createState() => _ScoreHomeState();
}

class _ScoreHomeState extends State<ScoreHome> with SingleTickerProviderStateMixin {
  int number = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isDarkMode = false;
  String currentTeam = "Team A";
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void increaseNumber() {
    setState(() {
      number++;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void decreaseNumber() {
    setState(() {
      number--;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void reset() {
    setState(() {
      number = 0;
      _animationController.reset();
      _animationController.forward();
    });
  }
  
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
  
  void showTeamSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Team",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.people, color: Theme.of(context).colorScheme.primary),
                title: Text("Team A"),
                onTap: () {
                  setState(() {
                    currentTeam = "Team A";
                    reset();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.people, color: Theme.of(context).colorScheme.primary),
                title: Text("Team B"),
                onTap: () {
                  setState(() {
                    currentTeam = "Team B";
                    reset();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.people, color: Theme.of(context).colorScheme.primary),
                title: Text("Team C"),
                onTap: () {
                  setState(() {
                    currentTeam = "Team C";
                    reset();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  void showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text("Dark Mode"),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.restore),
              title: Text("Reset Score"),
              onTap: () {
                reset();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = isDarkMode || MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? colorScheme.background : Colors.green.shade50,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Score Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: showSettings,
            tooltip: "Settings",
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.onPrimary,
                    radius: 30,
                    child: Icon(
                      Icons.sports,
                      size: 30,
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Score Tracker",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Keep track of your scores",
                    style: TextStyle(
                      color: colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Team Selection"),
              onTap: () {
                Navigator.pop(context);
                showTeamSelector();
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Score History"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Score History feature coming soon!"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Toggle Theme"),
              onTap: () {
                Navigator.pop(context);
                toggleTheme();
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: "Score Tracker",
                  applicationVersion: "1.0.0",
                  applicationIcon: Icon(
                    Icons.sports_score,
                    color: colorScheme.primary,
                    size: 50,
                  ),
                  children: [
                    Text("A beautiful score tracking app for all your games and sports events."),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.refresh),
        label: Text("Reset"),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 4,
        onPressed: reset,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [colorScheme.background, colorScheme.background.withOpacity(0.8)]
                : [Colors.green.shade50, Colors.green.shade100],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentTeam,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: showTeamSelector,
                    icon: Icon(Icons.swap_horiz),
                    label: Text("Change"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Current Score",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1 + (_animation.value * 0.2),
                          child: child,
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              colorScheme.primaryContainer,
                              colorScheme.primary.withOpacity(0.7),
                            ],
                            radius: 0.85,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$number',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 80,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: increaseNumber,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: Icon(Icons.add, size: 28),
                          label: Text(
                            'Add Point',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: decreaseNumber,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: Icon(Icons.remove, size: 28),
                          label: Text(
                            'Subtract',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickButton("+2", () {
                    setState(() {
                      number += 2;
                      _animationController.reset();
                      _animationController.forward();
                    });
                  }, Colors.blue.shade400),
                  _buildQuickButton("+3", () {
                    setState(() {
                      number += 3;
                      _animationController.reset();
                      _animationController.forward();
                    });
                  }, Colors.green.shade400),
                  _buildQuickButton("-1", () {
                    setState(() {
                      number -= 1;
                      _animationController.reset();
                      _animationController.forward();
                    });
                  }, Colors.orange.shade400),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickButton(String label, VoidCallback onPressed, Color color) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}