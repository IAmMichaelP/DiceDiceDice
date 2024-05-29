import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/welcome_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Image.asset(
                    width: 70,
                    'assets/ddd_logo.png',
                  ),
                ),
                Stack(
                  children: [
                    // Outline text
                    Text(
                      "WELCOME",
                      style: TextStyle(
                        fontSize: 68,
                        fontFamily: 'NewRocker',
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = Color(0xFF011422), // Outline color
                      ),
                    ),
                    // Solid text
                    Text(
                      "WELCOME",
                      style: TextStyle(
                        fontSize: 68,
                        fontFamily: 'NewRocker',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9A6738), // Fill color
                        decoration: TextDecoration.underline, // Underline
                        decorationColor: Color(0xFF9A6738),
                      ),
                    ),
                  ],
                ),
                Text(
                  "INDECISIVE ADVENTURER",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'NewRocker',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC36036), // Fill color
                  ),
                ),
                SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF161312),
                    shadowColor: Colors.black,
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xFF8C5E33), width: 2.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 30.0, right: 30, top: 5, bottom: 5),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 28, color: Color(0xFF8C5E33)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF161312),
                    shadowColor: Colors.black,
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0xFF8C5E33), width: 2.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 41.0, right: 41, top: 5, bottom: 5),
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 28, color: Color(0xFF8C5E33)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
