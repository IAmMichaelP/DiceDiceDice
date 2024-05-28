import 'package:flutter/material.dart';
import 'ask_screen.dart';
import 'dice_value.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ChooseDice(),
        '/add_choices': (context) => AddChoicesScreen(),
      },
    );
  }
}


class ChooseDice extends StatefulWidget {
  @override
  _ChooseDiceState createState() => _ChooseDiceState();
}

class _ChooseDiceState extends State<ChooseDice> {
  int? _selectedDiceSide;

  final diceImages = [
    'assets/d4.png',
    'assets/d6.png',
    'assets/d8.png',
    'assets/d10.png',
    'assets/d12.png',
    'assets/d20.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181415),
      appBar: AppBar(
        backgroundColor: Color(0xFF181415),
        title: Text(
          'CHOOSE A DICE',
          style: TextStyle(
            fontFamily: 'NewRocker',
            fontSize: 30,
            color: Color(0xFFAD6626),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: diceImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_selectedDiceSide == DiceValues.sides[index]) {
                          _selectedDiceSide = null;
                        } else {
                          _selectedDiceSide = DiceValues.sides[index];
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedDiceSide == DiceValues.sides[index]
                          ? Colors.blueGrey
                          : Color(0xFF2E353D),
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Color(0xFF042942), width: 2.0),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          diceImages[index],
                          width: 200,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'D${DiceValues.sides[index]}',
                          style: TextStyle(
                            fontFamily: 'Brawler',
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedDiceSide != null) {
                  Navigator.pushNamed(
                    context,
                    '/add_choices',
                    arguments: _selectedDiceSide,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF181415),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: BorderSide(color: Color(0xFF042942), width: 3.0),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Color(0xFF8C5E33),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Brawler',
                ),
              ),
            ),
            SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}
