import 'package:flutter/material.dart';
import 'dice_screen.dart';

class ResultScreen extends StatelessWidget {
  final String question;
  final String result;
  final int rolledNumber;

  ResultScreen({
    required this.question,
    required this.result,
    required this.rolledNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161312),
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Color(0xFF161312),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFF8C5E33),
              padding: EdgeInsets.all(10),
              child: Text(
                'Question: $question', // Display the question
                style: TextStyle(
                  fontFamily: 'Brawler',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              color: Color(0xFF8263214), // Brown color
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Result: $result',
                    style: TextStyle(
                      fontFamily: 'Brawler',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'You rolled: ${rolledNumber + 1}',
                    style: TextStyle(
                      fontFamily: 'Brawler',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF161312),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: BorderSide(color: Color(0xFF08C5E33), width: 2.0),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text(
                    'AGAIN',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF8C5E33),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChooseDice(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF161312),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: BorderSide(color: Color(0xFF08C5E33), width: 2.0),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF8C5E33),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
