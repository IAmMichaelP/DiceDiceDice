import 'package:flutter/material.dart';
import 'dart:math';
import 'result_screen.dart';

class RollDiceScreen extends StatefulWidget {
  final String question;
  final List<String> choices;

  RollDiceScreen({
    required this.question,
    required this.choices,
  });

  @override
  _RollDiceScreenState createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  late String _question;
  late List<String> _choices;
  late String _selectedChoice; // New variable to hold the selected choice

  @override
  void initState() {
    super.initState();
    _question = widget.question;
    _choices = widget.choices;
    _selectedChoice = ''; // Initialize selected choice
  }

  void _rollDice() {
    // Select a random index to simulate rolling the dice
    int rolledIndex = Random().nextInt(_choices.length);
    setState(() {
      // Update the selected choice
      _selectedChoice = _choices[rolledIndex];
    });

    // Navigate to the result screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          question: _question,
          result: _selectedChoice, // Pass the selected choice
          rolledNumber: rolledIndex, // Pass the rolled index as the rolled number
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181415),
      appBar: AppBar(
        backgroundColor: Color(0xFF181415),
        title: Text(
          'Let\'s Roll',
          style: TextStyle(
            fontFamily: 'NewRocker',
            fontSize: 30,
            color: Color(0xFFAD6626),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _question,
              style: TextStyle(
                fontFamily: 'Brawler',
                fontSize: 25,
                color: Color(0xFF8C5E33),
              ),
            ),
            SizedBox(height: 20),
            Center( // Center the dice button
              child: ElevatedButton(
                onPressed: _rollDice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E353D),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(50),
                ),
                child: Text(
                  'Roll',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
