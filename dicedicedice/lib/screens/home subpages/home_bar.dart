import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../service/database_service.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeBar extends StatefulWidget {
  final String uid;
  HomeBar({required this.uid});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  final FocusNode _focusNode =
      FocusNode(); // Define FocusNode for TextFormField
  bool _textFieldFocused = false; // Track if TextFormField has focus
  List<String> interpretationList = [
    'very negative',
    'negative',
    'positive',
    'very positive'
  ];
  final Random random = Random();
  int currentImageIndex = 0;
  int counter = 1;
  int diceResult = 0;

  final List<String> d20_images = [
    'assets/d20/1d20.png',
    'assets/d20/2d20.png',
    'assets/d20/3d20.png',
    'assets/d20/4d20.png',
    'assets/d20/5d20.png',
    'assets/d20/6d20.png',
    'assets/d20/7d20.png',
    'assets/d20/8d20.png',
    'assets/d20/9d20.png',
    'assets/d20/10d20.png',
    'assets/d20/11d20.png',
    'assets/d20/12d20.png',
    'assets/d20/13d20.png',
    'assets/d20/14d20.png',
    'assets/d20/15d20.png',
    'assets/d20/16d20.png',
    'assets/d20/17d20.png',
    'assets/d20/18d20.png',
    'assets/d20/19d20.png',
    'assets/d20/20d20.png',
  ];
  final List<String> d12_images = [
    'assets/d12/1d12.png',
    'assets/d12/2d12.png',
    'assets/d12/3d12.png',
    'assets/d12/4d12.png',
    'assets/d12/5d12.png',
    'assets/d12/6d12.png',
    'assets/d12/7d12.png',
    'assets/d12/8d12.png',
    'assets/d12/9d12.png',
    'assets/d12/10d12.png',
    'assets/d12/11d12.png',
    'assets/d12/12d12.png',
  ];
  final List<String> d10_images = [
    'assets/d10/1d10.png',
    'assets/d10/2d10.png',
    'assets/d10/3d10.png',
    'assets/d10/4d10.png',
    'assets/d10/5d10.png',
    'assets/d10/6d10.png',
    'assets/d10/7d10.png',
    'assets/d10/8d10.png',
    'assets/d10/9d10.png',
    'assets/d10/10d10.png',
  ];
  final List<String> d8_images = [
    'assets/d8/1d8.png',
    'assets/d8/2d8.png',
    'assets/d8/3d8.png',
    'assets/d8/4d8.png',
    'assets/d8/5d8.png',
    'assets/d8/6d8.png',
    'assets/d8/7d8.png',
    'assets/d8/8d8.png',
  ];
  final List<String> d6_images = [
    'assets/d6/1d6.png',
    'assets/d6/2d6.png',
    'assets/d6/3d6.png',
    'assets/d6/4d6.png',
    'assets/d6/5d6.png',
    'assets/d6/6d6.png',
  ];
  final List<String> d4_images = [
    'assets/d4/1d4.png',
    'assets/d4/2d4.png',
    'assets/d4/3d4.png',
    'assets/d4/4d4.png',
  ];
  final List<String> dice_all = [
    'assets/d4/4d4.png',
    'assets/d6/6d6.png',
    'assets/d8/8d8.png',
    'assets/d10/9d10.png',
    'assets/d12/12d12.png',
    'assets/d20/20d20.png',
  ];
  List<String> currentDiceImages = [];
  final AudioPlayer player = AudioPlayer();

  String question = '';
  String interpretation = '';
  Timestamp timeStamp = Timestamp.now();
  String dice = '';
  List<String> diceType = ['d4', 'd6', 'd8', 'd10', 'd12', 'd20'];

  @override
  void initState() {
    super.initState();
    currentDiceImages = d20_images; // default dice images
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final GlobalKey<_HomeBarState> _myWidgetKey = GlobalKey<_HomeBarState>();
    final authService = Provider.of<AuthService>(context);
    final String? uid = authService.uid;
    final databaseService = DatabaseService(uid: uid);

    void saveQuestion() async {
      print("dice result: $diceResult");
      // dice = "$currentDiceImages"; // Save the current dice type
      print("dice result: $dice");

      interpretation = interpretationList[diceResult - 1];

      // interpretation =
      //     interpretationList[diceResult ~/ (20 / interpretationList.length)];
      print("interpretation result: $interpretation");
      print("timestamp result: $timeStamp");
      dynamic result = await databaseService.setUserHistory(
          question, diceResult, interpretation, timeStamp, dice);
      print(result);
      print('history');
    }

    void rollDice() {
      // Roll the dice
      Timer.periodic(const Duration(milliseconds: 80), (timer) {
        counter++;
        setState(() {
          currentImageIndex = random.nextInt(currentDiceImages.length);
        });
        if (counter >= 13) {
          timer.cancel();
          setState(() {
            counter = 1;
            diceResult = currentImageIndex + 1;
            print('dice result: $diceResult');
            saveQuestion();
          });
        }
      });
    }

    void updateDiceImages(int index) {
      switch (index) {
        case 0:
          currentDiceImages = d4_images;
          break;
        case 1:
          currentDiceImages = d6_images;
          break;
        case 2:
          currentDiceImages = d8_images;
          break;
        case 3:
          currentDiceImages = d10_images;
          break;
        case 4:
          currentDiceImages = d12_images;
          break;
        // case 5:
        default:
          dice = 'd20';
          currentDiceImages = d20_images;
      }
    }

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/Dice-cider.png'),
            const SizedBox(height: 10),
            Image.asset('assets/subtitle.png'),
            const SizedBox(height: 30),
            Transform.rotate(
              angle: random.nextDouble() * 180,
              child: Image.asset(
                currentDiceImages[currentImageIndex],
                height: 100,
              ),
            ),
            const SizedBox(height: 30),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85),
                        filled: true,
                        fillColor: Color(0xFF8C5E33), // Background color
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 143, 94,
                                  11)), // Border radius when focused
                        ),
                        hintText: 'Enter your indecisiveness here',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 55, 44, 44),
                            fontFamily: 'Brawler'),
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Brawler'),
                      onChanged: (value) {
                        question = value;
                      },
                      validator: (value) {
                        if (value?.trim().isEmpty ?? false) {
                          return "Please provide indecisiveness";
                        }
                        return null;
                      }, // Text color
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          rollDice();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.7, 55),
                        side: const BorderSide(
                            color: Color(0xFF8C5E33), width: 2.0),
                        backgroundColor: Color(0xFF161312), // Button color
                        foregroundColor: Color(0xFF8C5E33), // Text color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Roll A Dice',
                          style: TextStyle(
                              fontFamily: 'Brawler',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: dice_all.map((diceImage) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              dice = diceType[dice_all.indexOf(diceImage)];
                              updateDiceImages(dice_all.indexOf(diceImage));
                            });
                          },
                          child: Container(
                            height: 75,
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset(
                              diceImage,
                              height: 50,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
