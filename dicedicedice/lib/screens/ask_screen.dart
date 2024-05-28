import 'package:flutter/material.dart';
import 'roll_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add choices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AddChoicesScreen(),
        '/roll_dice': (context) => RollDiceScreen(question: '',choices: [],),
      },
    );
  }
}

class AddChoicesScreen extends StatefulWidget {
  @override
  _AddChoicesScreenState createState() => _AddChoicesScreenState();
}

class _AddChoicesScreenState extends State<AddChoicesScreen> {
  late int _diceSide = 6; // Set a default value for _diceSide
  final List<TextEditingController> _controllers = [];
  late TextEditingController _questionController;

  String _question = '';
  List<String> _choices = [];

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    _diceSide = args as int? ?? 6; // Default value of 6
    _controllers.clear(); // Clear existing controllers before adding new ones
    _choices = List<String>.filled(_diceSide, ''); // Initialize _choices with empty strings
    for (int i = 0; i < _diceSide; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181415),
      appBar: AppBar(
        backgroundColor: Color(0xFF181415),
        title: Text(
          'Add Choices',
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
          children: [
            TextField(
              controller: _questionController,
              onChanged: (value) {
                setState(() {
                  _question = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF2E353D),
                border: OutlineInputBorder(),
                labelText: 'Question',
                labelStyle: TextStyle(
                  color: Color(0xFF8C5E33),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Enter Choices:',
              style: TextStyle(
                fontFamily: 'Brawler',
                fontSize: 25,
                color: Color(0xFF8C5E33),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _diceSide,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[index],
                      onChanged: (value) {
                        setState(() {
                          _choices[index] = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF2E353D),
                        border: OutlineInputBorder(),
                        labelText: 'Choice ${index + 1}',
                        labelStyle: TextStyle(
                          color: Color(0xFF8C5E33),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                List<String> choices = _controllers
                    .where((controller) => controller.text.isNotEmpty)
                    .map((controller) => controller.text)
                    .toList();
                setState(() {
                  _choices = choices;
                });
                String question = _questionController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RollDiceScreen(
                      question: question,
                      choices: choices,
                    ),
                  ),
                );
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
                'Let\'s Roll',
                style: TextStyle(
                  color: Color(0xFF8C5E33),
                  fontSize: 20,
                  fontFamily: 'Brawler',
                ),
              ),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
